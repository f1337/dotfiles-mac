function jekyll
	docker run --rm -i -p 4000:4000 -v=$PWD:/srv/jekyll jekyll/jekyll jekyll $argv
end
