.DEFAULT_GOAL := all
.PHONY: all clean development public deploy

all: development
	@:

watch:
	hugo -w

development:
	hugo

public:
	hugo --environment public

deploy:
	rsync -auvz public/ scorpion:/var/www/html/

clean:
	$(RM) -r development/* public/*
