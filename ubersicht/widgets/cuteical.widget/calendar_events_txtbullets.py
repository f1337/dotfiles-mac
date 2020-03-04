#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import subprocess


def prettify_calendar():
    html = ""
    bullets = ["<span class='square'>■</span>", "<span class='heart'>♥</span>",
               "<span class='triangle'>▼</span>", "<span class='circle'>●</span>"]
    bullet_counter = 0

    # remove error from icalbuddy and get calendar info for today
    with open(os.devnull, 'w') as devnull:
        try:
            raw_events = subprocess.check_output(["./cuteical.widget/icalBuddy", "-nrd", "-nc",
                                                  "-b", "❤︎ ", "-eep", "location,url,notes,attendees", "eventsFrom:now", "to:today"], stderr=devnull)
            html, bullet_counter = display_events(
                html, "Today", raw_events, bullets, bullet_counter)
        except subprocess.CalledProcessError as e:
            print "Error with icalBuddy: ", e.message

    # # remove error from icalbuddy and get calendar info for tomorrow
    # with open(os.devnull, 'w') as devnull:
    #     try:
    #         raw_events = subprocess.check_output(["./cuteical.widget/icalBuddy", "-nrd", "-nc", "-b", "❤︎ ",
    #                                               "-eep", "location,url,notes,attendees", "eventsFrom:today+1", "to:today+1"], stderr=devnull)
    #         html, bullet_counter = display_events(
    #             html, "Tomorrow", raw_events, bullets, bullet_counter)
    #     except subprocess.CalledProcessError as e:
    #         print "Error with icalBuddy: ", e.message

    print html


def display_events(html, what_day, raw_events, bullets, bullet_counter):
    events = raw_events.split("\n")
    html += "<div class='today'>\n<div class='title'>"+what_day+"</div>"
    # display events for the day
    if len(events) < 2:
        html += "<div class='event_time'>Live like you wanna " + \
            "let yesterday burn and throw it in the fire.</div>"
    else:
        for i in range(len(events)):
            if events[i].find("❤︎") != -1:
                html += "\n<div class='event_title'>" + \
                    events[i].replace("❤︎", bullets[bullet_counter])+"</div>"
                if bullet_counter < 3:
                    bullet_counter += 1
                else:
                    bullet_counter = 0
            elif events[i] == "":
                pass
            else:
                # drop the date, only show the time
                event_time = events[i].split(" at ")
                html += "\n<div class='event_time'>"+event_time[1]+"</div>"
    # close  div
    html += "\n</div>"
    return html, bullet_counter


prettify_calendar()
