NAME=vim

TEST_FILES = $(wildcard tests/*.pp)

test: $(NAME) dependencies
	for file in $(TEST_FILES); do \
	  puppet apply --modulepath=`pwd`/$(NAME) --noop $$file || exit 1; \
	done

# FIXME: document then remove the no-documentation-check
check: $(NAME)
	puppet-lint --with-filename --fail-on-warnings --no-documentation-check --no-80chars-check vim/manifests/*.pp

# do an ugly symlink so we can rely on the name being known
$(NAME):
	ln -sf . $(NAME)

DEPENDENCIES = concat stdlib vcsrepo wget

dependencies: $(DEPENDENCIES)

concat:
	git clone git@github.com:puppetlabs/puppet-concat.git concat

stdlib:
	git clone git@github.com:puppetlabs/puppetlabs-stdlib.git stdlib

vcsrepo:
	git clone git@github.com:puppetlabs/puppetlabs-vcsrepo.git vcsrepo

wget:
	git clone git@github.com:maestrodev/puppet-wget.git wget


clean:
	rm $(NAME)
	rm -rf $(DEPENDENCIES)
