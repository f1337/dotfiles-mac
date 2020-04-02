#!/usr/bin/python
# -*- coding: utf-8 -*-

import commands
import json
import urllib
import urllib2
import re
from Foundation import *
from ScriptingBridge import *

geniusAccessToken = "8pLbbrbgdIsXgWr8ZM1TJmAqq1Cg3xa7mdSWgbAd8EmOkKTEM9I_IZtcwC4xbnXj"

#---- Genius API ----

api_url = "https://api.genius.com"
html_url = "https://genius.com"
headers = {
  "Authorization": "Bearer " + geniusAccessToken,
  "Content-Type": "application/json",
  "User-Agent": "Mozilla/5.0"
}

#---- iTunes Scripting Bridge ----

iTunes = SBApplication.applicationWithBundleIdentifier_("com.apple.Music")
playerState = str(iTunes.playerState())[-2:]

#---- vars to cache current track info ----

artist = ""
album = ""
song = ""
lyrics = ""

# strip <script>…</script> blocks
def strip_script(html):
  pattern = re.compile(r'<script[^>]+>.*?</script>', re.MULTILINE + re.DOTALL + re.IGNORECASE)
  return pattern.sub('', html)

# strip all tags except <p>…</p> and <br/>
def strip_tags(html):
  output = html
  pattern = re.compile(r'(<[^>]+>)', re.MULTILINE + re.DOTALL + re.IGNORECASE)
  tags = pattern.findall(html)

  for tag in tags:
    if tag[:2] != '<p' and tag[:3] != '<br':
      output = output.replace(tag, '')

  return output

# scrape lyrics from genius.com HTML
def scrape_genius_lyrics(path):
  page_url = html_url + path
  html = get_request(page_url, { "User-Agent": "Mozilla/5.0" })
  # grab the lyrics div using non-greedy regex
  matches = re.search(r'<div class="lyrics">(.*?)</div>', html, re.MULTILINE + re.DOTALL + re.IGNORECASE)
  lyrics_html = matches.group(0)
  # cleanup the HTML
  lyrics_html = strip_script(lyrics_html)
  lyrics_html = strip_tags(lyrics_html)
  return lyrics_html

# format the API search query
def get_query():
  # strip featured artist parentheses from song names
  # pattern = re.compile(r'\(([Ff]eat|[Ww]ith)[^\)]+\)')
  # strip all parentheses from song names
  pattern = re.compile(r'\([^\)]+\)')
  sanitized_song_name = pattern.sub('', song)
  query = { 'q': sanitized_song_name }
  return urllib.urlencode(query)

# lookup song path via genius API
def get_genius_song_path():
  query = get_query()
  url = api_url + "/search?" + query
  output = get_request(url, headers)
  data = json.loads(output)

  song_info = None
  for hit in data["response"]["hits"]:
    if hit["result"]["primary_artist"]["name"].lower() == artist.lower():
      song_info = hit
      break

  if song_info:
    song_url = api_url + song_info["result"]["api_path"]
    output = get_request(song_url, headers)
    data = json.loads(output)
    return data["response"]["song"]["path"]
  else:
    return None

# get current track & lyrics from iTunes
def get_song_info():
  global artist, album, song, lyrics, state
  track = iTunes.currentTrack

  artist = track.artist
  album = track.album
  song = track.name
  lyrics = track.lyrics

  # if there are no custom lyrics, look them up via Genius
  # if song != "" and lyrics == "":
  #   song_path = get_genius_song_path()
  #   if song_path:
  #     lyrics = scrape_genius_lyrics(song_path)

def get_request(url, headers):
  req = urllib2.Request(url, headers=headers)
  f = urllib2.urlopen(req)
  output = f.read()
  f.close()
  return output

def player_state():
  state = str(iTunes.playerState)[-2:]
  if state == "10":
    return "fast-forwarding"
  elif state == "20":
    return "playing"
  elif state == "22":
    return "rewinding"
  elif state == "23":
    return "stopped"
  elif state == "52":
    return "paused"
  else:
    return "unknown"


  # # don't ping APIs and scrape pages if nothing changed
  # if song == track.name() and artist == track.artist():
  #   state = "unchanged"
  #   return
# print artist
# print iTunes.currentTrack().artist()
# print song
print iTunes.currentTrack().artist()
# print (list(set(dir(iTunes)) - set(dir(SBApplication))))
# print (list(set(dir(iTunes.currentTrack())) - set(dir(SBObject))))

state = player_state()
# if state == "playing":
# get_song_info()

print json.dumps({
  "state": state,
  "artist": artist,
  "song": song,
  "album": album,
  "lyrics": lyrics
})
