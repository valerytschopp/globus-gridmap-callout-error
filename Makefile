name=globus-gridmap-callout-error
deb_name=libglobus-gridmap-callout-error
version=0.3

debbuild_dir=$(CURDIR)/debbuild
tgz_dir=$(CURDIR)/tgz
deb_dir=$(CURDIR)/debs


all: deb-src

clean:
	@echo "Cleaning..."
	rm -fr $(debbuild_dir) $(tgz_dir) $(deb_dir)
    

get-upstream:
	@echo "Get upstream version..."
	make -f debian/rules get-orig-source


pre_debbuild:
	@echo "Prepare for build..."
	mkdir -p $(debbuild_dir)
	cp -v $(name)_$(version).orig.tar.gz $(debbuild_dir)
	tar -C $(debbuild_dir) -xvf $(name)_$(version).orig.tar.gz
	cp -vr debian $(debbuild_dir)/$(name)-$(version)


deb-src: pre_debbuild
	@echo "Building Debian source package in $(debbuild_dir)"
	cd $(debbuild_dir) && dpkg-source -b $(name)-$(version)


deb: pre_debbuild
	@echo "Building Debian package in $(debbuild_dir)"
	cd $(debbuild_dir)/$(name)-$(version) && debuild -us -uc 
	
	
etics:
	@echo "Publish Debian/tarball"
	mkdir -p $(tgz_dir) $(deb_dir)
	test ! -f $(name)-$(version).orig.tar.gz || cp -v $(name)-$(version).orig.tar.gz $(tgz_dir)/$(name)-$(version).src.tar.gz
	test ! -f $(debbuild_dir)/$(name)_$(version)-*.dsc || cp -v $(debbuild_dir)/$(name)_$(version)-*.dsc $(deb_dir)
	test ! -f $(debbuild_dir)/$(name)_$(version)-*.debian.tar.gz || cp -v $(debbuild_dir)/$(name)_$(version)-*.debian.tar.gz $(deb_dir)
	test ! -f $(debbuild_dir)/$(name)_$(version).orig.tar.gz || cp -v $(debbuild_dir)/$(name)_$(version).orig.tar.gz $(deb_dir)
	if [ -f $(debbuild_dir)/$(name)_$(version)-*.deb ] ; then \
		cp -v $(debbuild_dir)/$(name)_$(version)-*.deb $(deb_dir) ; \
		test ! -d $(tmp_dir) || rm -fr $(tmp_dir) ; \
		mkdir -p $(tmp_dir) ; \
		dpkg -x $(debbuild_dir)/$(name)_$(version)-*.deb $(tmp_dir) ; \
		cd $(tmp_dir) ; \
		tar -C $(tmp_dir) -czf $(name)-$(version).tar.gz * ; \
		mv -v $(name)-$(version).tar.gz $(tgz_dir) ; \
		rm -fr $(tmp_dir) ; \
	fi
