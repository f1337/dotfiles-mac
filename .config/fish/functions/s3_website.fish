function s3_website
	docker run --rm -i -v=$PWD/_site:/website -v=$PWD:/config attensee/s3_website $argv --config-dir /config --site /website
end
