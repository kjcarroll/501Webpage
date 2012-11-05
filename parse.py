#! /bin/python2

import urllib
import ast

maxJSON = 0
masterList = {}

def getMax():
    maxJSON = urllib.urlopen('http://xkcd.com/info.0.json').read()
    maxJSON = ast.literal_eval(maxJSON)
    global maxJSON
    maxJSON = maxJSON["num"]


def buildMasterList():
    for f in range(1, maxJSON+1):
        if f == 404:
            continue
        url = 'http://xkcd.com/%s/info.0.json' % f
        data = urllib.urlopen(url).read()
        data = ast.literal_eval(data)
        print "Inserting data for comic number %s" %f
        global masterList
        masterList[f] = data

def printEntry(n):
    print masterList[n]

def search(query):
    for f in range(1, maxJSON+1):
        if f == 404:
            continue
        curEntry = str(masterList[f])
        if curEntry.find(query) != -1:
            print curEntry
        else:
            continue
