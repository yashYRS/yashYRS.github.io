### A website that serves as a blog and an online portfolio, made using jekyll


#### Steps to install and use this template

- Clone this repository
```
	git clone https://github.com/yashYRS/yashYRS.github.io
```
- Install all the prerequisites for jekyll
```
	sudo apt-get install ruby-full build-essential zlib1g-dev
```
- Keep all installations made from ruby-gems only for current user
```
	echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
	echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
	echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
	source ~/.bashrc
```
- Install Jekyll and bundler
```
	gem install jekyll bundler
```
- To run the website locally
```
	bundle exec jekyll serve
```

#### Acknowledgement

I discovered this template from Dheeraj R Reddy's [(Squadrick)](https://squadrick.dev/) [repository](https://github.com/Squadrick/squadrick.github.io/), a fellow batchmate from my undergraduate alma-mater. He is one of best coders I have personally interacted with. Do give him a shoutout, in case you end up using this.
