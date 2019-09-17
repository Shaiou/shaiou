#!/usr/bin/env python

from os import getenv
from os.path import abspath,isfile,realpath,join,dirname
import boto3
import flask
import configparser
import json
import urllib
import requests
import sys

useralias = 'bob'
app = flask.Flask(__name__)

@app.route('/login/<profile>')
def login(profile):
    session = boto3.session.Session(profile_name=profile)
    userarn = session.client('sts').get_caller_identity()['Arn']
    username = userarn.split('/')[-1]
    policies = session.client('iam').list_attached_user_policies(UserName=username)
    creds = session.client('sts').get_federation_token(
        Name = useralias,
        Policy='{\
            "Version":"2012-10-17",\
            "Statement":[{\
                "Sid":"s",\
                "Effect":"Allow",\
                "Action":"*",\
                "Resource":"*"}]}'
    )['Credentials']

    jsoncreds = '{{"sessionId":"{0}","sessionKey":"{1}","sessionToken":"{2}"}}'.format(
                                        creds['AccessKeyId'],
                                        creds['SecretAccessKey'],
                                        creds['SessionToken'])

    url = 'https://signin.aws.amazon.com/federation\
?Action=getSigninToken&Session='+urllib.quote_plus(jsoncreds)
    r = requests.get(url)
    url='https://signin.aws.amazon.com/federation\
?Action=login\
&Issuer=https%3A%2F%2Fexample.com\
&Destination=https%3A%2F%2Fconsole.aws.amazon.com%2F\
&SigninToken='+json.loads(r.text)['SigninToken']
    return flask.redirect(url,code='302')

@app.route("/")
def main():
    index = '<!DOCTYPE html><html lang="en"><body>'
    config = configparser.RawConfigParser()
    config.read(join(getenv('HOME'),'.aws/credentials'))
    iconsize = "40"
    width = "160"
    height= "45"
    for profile in config.sections():
        imgfile = abspath(join(dirname(__file__),'img',profile+'.jpg'))
        imgcode = ""
        if isfile(imgfile):
            imgcode = '<img \
align="left" \
src="img/{0}.jpg" \
width="{1}" \
height="{1}" \
alt=""/>'.format(profile,iconsize)
        index += '\
<a href="/login/{0}">\
<button\
    style="height:{3}px;width:{2}px;text-align:center"\
    type="submit"\
    value="{0}">{1}\
    {0}\
</button>\
</a></br>'.format(profile,imgcode,width,height)
    index += '</body></html>'
    return flask.render_template_string(index)

@app.route('/img/<path:path>')
def img(path):
    imgpath=abspath(join(dirname(__file__),'img',path)) 
    return flask.send_file(imgpath, mimetype='image/jpeg')

if __name__ == "__main__":
    app.run()

