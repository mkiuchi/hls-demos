vod/done: vod/test3 vod/test2 vod/test1
	touch vod/done

vod/test3: vod/test3-01.m3u8
	touch vod/test3

vod/test3-01.m3u8: source.mp4 vod
	/usr/bin/ffmpeg -y -i source.mp4 \
		-map 0:a:0 \
		-vn \
		-c:a aac -b:a 64k -ac 2 -ar 48000 \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test3-01_audio01_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test3-01_audio01_init.mp4 \
			vod/test3-01_audio01_playlist.m3u8
	/usr/bin/ffmpeg -y -i source.mp4 \
		-map 0:v \
		-vf "scale=-2:240,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 256k -maxrate 512k -bufsize 512k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-an \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test3-01_240p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test3-01_240p_init.mp4 \
			vod/test3-01_240p_playlist.m3u8 \
		-vf "scale=-2:480,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 512k -maxrate 768k -bufsize 768k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-an \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test3-01_480p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test3-01_480p_init.mp4 \
			vod/test3-01_480p_playlist.m3u8 \
		-vf "scale=-2:720,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 1000k -maxrate 1536k -bufsize 1536k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-an \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test3-01_720p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test3-01_720p_init.mp4 \
			vod/test3-01_720p_playlist.m3u8 \
		-vf "scale=-2:1080,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 2000k -maxrate 3072k -bufsize 3072k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-an \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test3-01_1080p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test3-01_1080p_init.mp4 \
			vod/test3-01_1080p_playlist.m3u8
	@echo "#EXTM3U" > vod/test3-01.m3u8
	@echo "" >> vod/test3-01.m3u8
	@echo "#EXT-X-VERSION:5" >> vod/test3-01.m3u8
	@echo "#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID=\"a0\",NAME=\"English\",LANGUAGE=\"en-US\",AUTOSELECT=YES,DEFAULT=YES,CHANNELS=\"2\",URI=\"test3-01_audio01_playlist.m3u8\"" >> vod/test3-01.m3u8
	@echo "" >> vod/test3-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=512000,RESOLUTION=360x240,CODECS=\"avc1.42c00d,mp4a.40.2\",AUDIO=\"a0\"" >> vod/test3-01.m3u8
	@echo "test3-01_240p_playlist.m3u8" >> vod/test3-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=768000,RESOLUTION=720x480,CODECS=\"avc1.42c00d,mp4a.40.2\",AUDIO=\"a0\"" >> vod/test3-01.m3u8
	@echo "test3-01_480p_playlist.m3u8" >> vod/test3-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=1500000,RESOLUTION=1280x720,CODECS=\"avc1.42c00d,mp4a.40.2\",AUDIO=\"a0\"" >> vod/test3-01.m3u8
	@echo "test3-01_720p_playlist.m3u8" >> vod/test3-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=2048000,RESOLUTION=1920x1080,CODECS=\"avc1.42c00d,mp4a.40.2\",AUDIO=\"a0\"" >> vod/test3-01.m3u8
	@echo "test3-01_1080p_playlist.m3u8" >> vod/test3-01.m3u8

vod/test2: vod/test2-01.m3u8 vod/test2-02.mpd
	touch vod/test2

vod/test2-02.mpd: source.mp4 vod packager
	/usr/bin/ffmpeg -y -i source.mp4 \
		-map 0:v -map 0:a:0 \
		-vf "scale=-2:240,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 256k -maxrate 512k -bufsize 512k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 64k -ac 2 -ar 48000 \
			vod/test2-02_240p.mp4 \
		-vf "scale=-2:480,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 512k -maxrate 768k -bufsize 768k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			vod/test2-02_480p.mp4 \
		-vf "scale=-2:720,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 1000k -maxrate 1536k -bufsize 1536k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			vod/test2-02_720p.mp4 \
		-vf "scale=-2:1080,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 2000k -maxrate 3072k -bufsize 3072k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			vod/test2-02_1080p.mp4
	./packager \
		'in=vod/test2-02_240p.mp4,stream=video,init_segment=vod/test2-02_240p_init.mp4,segment_template=vod/test2-02_240p_stream$$Number$$.m4s' \
		'in=vod/test2-02_480p.mp4,stream=video,init_segment=vod/test2-02_480p_init.mp4,segment_template=vod/test2-02_480p_stream$$Number$$.m4s' \
		'in=vod/test2-02_720p.mp4,stream=video,init_segment=vod/test2-02_720p_init.mp4,segment_template=vod/test2-02_720p_stream$$Number$$.m4s' \
		'in=vod/test2-02_1080p.mp4,stream=video,init_segment=vod/test2-02_1080p_init.mp4,segment_template=vod/test2-02_1080p_stream$$Number$$.m4s' \
		--generate_static_live_mpd --mpd_output vod/test2-02.mpd

vod/test2-01.m3u8: source.mp4 vod
	/usr/bin/ffmpeg -y -i source.mp4 \
		-map 0:v -map 0:a:0 \
		-vf "scale=-2:240,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 256k -maxrate 512k -bufsize 512k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 64k -ac 2 -ar 48000 \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test2-01_240p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test2-01_240p_init.mp4 \
			vod/test2-01_240p_playlist.m3u8 \
		-vf "scale=-2:480,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v baseline -level:v 4.0 -b:v 512k -maxrate 768k -bufsize 768k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test2-01_480p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test2-01_480p_init.mp4 \
			vod/test2-01_480p_playlist.m3u8 \
		-vf "scale=-2:720,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 1000k -maxrate 1536k -bufsize 1536k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test2-01_720p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test2-01_720p_init.mp4 \
			vod/test2-01_720p_playlist.m3u8 \
		-vf "scale=-2:1080,yadif,format=yuv420p" \
			-c:v libx264 -preset medium \
			-profile:v main -level:v 4.0 -b:v 2000k -maxrate 3072k -bufsize 3072k \
			-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
			-c:a aac -b:a 96k -ac 2 -ar 48000 \
			-f hls -hls_segment_type fmp4 -segment_time 15 \
			-segment_list_size 0 -hls_playlist_type event \
			-hls_flags append_list \
			-hls_segment_filename vod/test2-01_1080p_stream%04d.m4s \
			-hls_base_url /vod/ \
			-hls_fmp4_init_filename test2-01_1080p_init.mp4 \
			vod/test2-01_1080p_playlist.m3u8
	@echo "#EXTM3U" > vod/test2-01.m3u8
	@echo "#EXT-X-VERSION:5" >> vod/test2-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=512000,RESOLUTION=360x240,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test2-01.m3u8
	@echo "test2-01_240p_playlist.m3u8" >> vod/test2-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=768000,RESOLUTION=720x480,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test2-01.m3u8
	@echo "test2-01_480p_playlist.m3u8" >> vod/test2-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=1500000,RESOLUTION=1280x720,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test2-01.m3u8
	@echo "test2-01_720p_playlist.m3u8" >> vod/test2-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=2048000,RESOLUTION=1920x1080,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test2-01.m3u8
	@echo "test2-01_1080p_playlist.m3u8" >> vod/test2-01.m3u8

vod/test1: vod/test1-01.m3u8 vod/test1-02.m3u8
	touch vod/test1

vod/test1-02.m3u8: source.mp4 vod
	# 音声トラックが複数含まれる
	/usr/bin/ffmpeg -y -i source.mp4 \
	-map 0:v -map 0:a \
	-vf "scale=-2:240,yadif,format=yuv420p" \
	-c:v libx264 -preset medium -profile:v baseline -level:v 4.0 -b:v 256k -maxrate 512k -bufsize 512k \
	-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
	-c:a aac -b:a 64k -ac 2 -ar 48000 \
	-f hls -hls_segment_type fmp4 -segment_time 15 \
	-segment_list_size 0 -hls_playlist_type event \
	-hls_flags append_list \
	-hls_segment_filename vod/test1-02_stream%04d.m4s \
	-hls_base_url /vod/ \
	-hls_fmp4_init_filename test1-02_init.mp4 \
	vod/test1-02_playlist.m3u8
	@echo "#EXTM3U" > vod/test1-02.m3u8
	@echo "#EXT-X-VERSION:5" >> vod/test1-02.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=768000,RESOLUTION=720x480,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test1-02.m3u8
	@echo "test1-02_playlist.m3u8" >> vod/test1-02.m3u8

vod/test1-01.m3u8: source.mp4 vod
	/usr/bin/ffmpeg -y -i source.mp4 \
	-map 0:v -map 0:a:0 \
	-vf "scale=-2:240,yadif,format=yuv420p" \
	-c:v libx264 -preset medium -profile:v baseline -level:v 4.0 -b:v 256k -maxrate 512k -bufsize 512k \
	-x264-params "scenecut=0:open_gop=0:min-keyint=72:keyint=72" \
	-c:a aac -b:a 64k -ac 2 -ar 48000 \
	-f hls -hls_segment_type fmp4 -segment_time 15 \
	-segment_list_size 0 -hls_playlist_type event \
	-hls_flags append_list \
	-hls_segment_filename vod/test1-01_stream%04d.m4s \
	-hls_base_url /vod/ \
	-hls_fmp4_init_filename test1-01_init.mp4 \
	vod/test1-01_playlist.m3u8
	@echo "#EXTM3U" > vod/test1-01.m3u8
	@echo "#EXT-X-VERSION:5" >> vod/test1-01.m3u8
	@echo "#EXT-X-STREAM-INF:BANDWIDTH=768000,RESOLUTION=720x480,CODECS=\"avc1.42c00d,mp4a.40.2\"" >> vod/test1-01.m3u8
	@echo "test1-01_playlist.m3u8" >> vod/test1-01.m3u8

vod:
	mkdir vod

source.mp4: Sintel_movie_720x306.ogv Cosmos_Laundromat.webm
	/usr/bin/ffmpeg -y -i Cosmos_Laundromat.webm -i Sintel_movie_720x306.ogv \
	-map 0:v -map 0:a -map 0:a -map 1:a -t 00:12:07 \
	-vf scale=-2:1080 \
	-c:v libx264 -preset medium -b:v 2048k \
	-metadata:s:a:0 language=und -metadata:s:a:1 language=eng -metadata:s:a:2 language=jpn \
	-c:a aac -b:a 96k source.mp4

Sintel_movie_720x306.ogv:
	@echo Sintel_movie_720x306.ogv not found. acuiring from Wikimedia Comons.
	wget https://upload.wikimedia.org/wikipedia/commons/7/75/Sintel_movie_720x306.ogv

Cosmos_Laundromat.webm:
	@echo Cosmos_Laundromat.webm not found. acuiring from Wikimedia Comons.
	wget -O Cosmos_Laundromat.webm https://upload.wikimedia.org/wikipedia/commons/3/36/Cosmos_Laundromat_-_First_Cycle_-_Official_Blender_Foundation_release.webm

packager:
	wget -O packager https://github.com/google/shaka-packager/releases/download/v2.4.3/packager-linux
	chmod a+x packager
