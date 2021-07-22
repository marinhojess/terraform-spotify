terraform {
  required_providers {
    spotify   = {
      version = "~> 0.1.5"
      source  = "conradludgate/spotify"
    }
  }
}

variable "spotify_api_key" {
  type = string
}

provider "spotify" {
  api_key = var.spotify_api_key
}

resource "spotify_playlist" "playlist" {
  name        = "Terraform Winter Playlist"
  description = "This playlist was created by Terraform"
  public      = true
  tracks = [
    for s in data.spotify_search_track.by_artist:
    "${s.tracks[0].id}"
  ]
}

data "spotify_search_track" "by_artist" {
  count    = "${length(var.artists)}"
  artists  =  [("${var.artists[count.index].singer}")]
  name     = "${var.artists[count.index].song}"
  limit    = 1
}
