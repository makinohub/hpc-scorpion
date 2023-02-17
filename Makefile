.DEFAULT_GOAL := all
.PHONY: all clean private public deploy

all: private
	@:

watch:
	hugo -w

private:
	hugo

public:
	hugo --environment public

deploy:
	rsync -auvz public/ scorpion:/var/www/html/

clean:
	$(RM) -r private/* public/*
