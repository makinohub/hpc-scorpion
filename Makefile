.DEFAULT_GOAL := all
.PHONY: all clean private public deploy

all: private
	@:

private:
	hugo --environment development

public:
	hugo --environment production

deploy:
	rsync -auv public/ scorpion:/var/www/html/

clean:
	$(RM) -r private/* public/*
