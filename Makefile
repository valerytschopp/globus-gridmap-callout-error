name=globus-gridmap-callout-error
version=0.3

debbuild_dir=$(CURDIR)/debbuild

clean:
	@echo "Cleaning..."
	rm -fr $(debbuild_dir)
    

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