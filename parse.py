#! /bin/python2

import urllib
import ast

maxJSON = 0
masterList = {}

def getMax():
    maxJSON = urllib.urlopen('http://xkcd.com/info.0.json').read()
    maxJSON = ast.literal_eval(maxJSON)
    maxJSON = maxJSON["num"]
    global maxJSON


def buildMasterList():
    getMax()
    for f in range(1, maxJSON+1):
        if f == 404:
            continue
        url = 'http://xkcd.com/%s/info.0.json' % f
        data = urllib.urlopen(url).read()
        data = ast.literal_eval(data)
        print "Inserting data for comic number %s" %f
        global masterList
        masterList[f] = data
    f = open('data', 'w')
    masterListString = str(masterList)
    f.write(masterListString)


def printEntry(n):
    print masterList[n]

def printCat(n, cat):
    print masterList[n][cat]


def search(query):
    for f in range(1, maxJSON+1):
        if f == 404:
            continue
        curEntry = str(masterList[f])
        if curEntry.find(query) != -1:
            print curEntry
        else:
            continue


def catSearch(cat, query):
    for f in range(1, maxJSON+1):
        if f == 404:
            continue
        curEntry = str(masterList[f][cat])
        if curEntry.find(query) != -1:
            printEntry(f)
        else:
            continue


def addTag(num, tag):
    masterList[num]['tags'].append(tag)


def initializeTags(num):
    masterList[num]['tags'] = []


def checkForMasterList():
    try:
        with open('data') as f:
            masterList = open('data', 'r').read()
            masterList = ast.literal_eval(masterList)
            global masterList
            getMax()
            pass
    except IOError as e:
        buildMasterList()

def printMasterList():
    print masterList
