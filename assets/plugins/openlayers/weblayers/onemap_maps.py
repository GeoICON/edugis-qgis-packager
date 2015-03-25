# -*- coding: utf-8 -*-

from weblayer import WebLayer3414

class OlOneMapMapsLayer(WebLayer3414):
    emitsLoadEnd = True

    def __init__(self, name, html):
        WebLayer3414.__init__(self, groupName="OneMap Maps", groupIcon="google_icon.png",
                              name=name, html=html)

class OlOneMapStreetsLayer(OlOneMapMapsLayer):
    def __init__(self):
        OlOneMapMapsLayer.__init__(self, name="OneMap Streets", html="onemap_streets.html")