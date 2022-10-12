import os

import sys



def MakeRange(fullString):

    #fullString = "  Displaying 1-50 of 329 records."

    range = fullString.split("Displaying")[1].split("of")[0].strip(" ")

    startRange = int(range.split("-")[0])

    endRange = int(range.split("-")[1])

    return endRange-startRange

   

def PageCount(count):

    return int(count.split("of")[1].strip(" "))