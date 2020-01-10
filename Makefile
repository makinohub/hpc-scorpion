.DEFAULT_GOAL := all
.PHONY: all clean public production deploy

all: public
	@:

public:
	hugo

production:
	hugo --environment $@

deploy:
	rsync -auv production/ scorpion:/var/www/html/

clean:
	$(RM) -r public/* production/*
