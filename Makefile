.DEFAULT_GOAL := all
.PHONY: all clean private public deploy

all: private
	@:

watch:
	hugo -w --environment development

private:
	hugo --environment development

public:
	hugo --environment production

deploy:
	rsync -auvz public/ scorpion:/var/www/html/

clean:
	$(RM) -r private/* public/*
