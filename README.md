# HLS Demos

## Usage

```
cd hls-demos
make
python3 -m http.server 8080
```

`make` generates sample movies. It takes several minutes.

then, open `http://localhost:8080/static/<player>?file=<Master HLS Playlist>` from your browser.

ex)
- http://localhost:8080/static/videojs.html?file=/vod/test1-01.m3u8
- http://localhost:8080/static/shaka.html?file=/vod/test1-01.m3u8

## List of Examples

1. Test1: simple streaming
    - Test1-01:
        - Video with single audio stream
            - Video.js: http://localhost:8080/static/videojs.html?file=/vod/test1-01.m3u8
            - Shaka: http://localhost:8080/static/shaka.html?file=/vod/test1-01.m3u8
    - Test1-02:
        - Video with three audio stream (but player cannot select)
            - Video.js: http://localhost:8080/static/videojs.html?file=/vod/test1-02.m3u8
            - Shaka: http://localhost:8080/static/shaka.html?file=/vod/test1-02.m3u8
2. Test2: Multiple bitrate video with single embedded audio. Experience ABR feature
    - Test2-01:
        - HLS package
            - Video.js: http://localhost:8080/static/videojs.html?file=/vod/test2-01.m3u8
            - Shaka: http://localhost:8080/static/shaka.html?file=/vod/test2-01.m3u8
    - Test2-02:
        - MPEG-DASH package (packed with Shaka packager)
            - Video.js(cannot play): http://localhost:8080/static/videojs.html?file=/vod/test2-02.mpd
            - Shaka: http://localhost:8080/static/shaka.html?file=/vod/test2-02.mpd
3. Test3: Multiple bitrate video with no audio and single audio stream. Video and audio muxed on client.
    - Test3-01:
        - HLS package
            - Video.js: http://localhost:8080/static/videojs.html?file=/vod/test3-01.m3u8
            - Shaka: http://localhost:8080/static/shaka.html?file=/vod/test3-01.m3u8


## Source

- Sintel: https://durian.blender.org/download/
    - © copyright Blender Foundation | www.sintel.org
- Cosmos Laundromat: https://gooseberry.blender.org/
    - (CC) Blender Foundation | gooseberry.blender.org

Video source - Wikimedia:

- Sintel: https://upload.wikimedia.org/wikipedia/commons/7/75/Sintel_movie_720x306.ogv
- Cosmos Laundromat: https://upload.wikimedia.org/wikipedia/commons/3/36/Cosmos_Laundromat_-_First_Cycle_-_Official_Blender_Foundation_release.webm
