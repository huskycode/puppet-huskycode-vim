NAME=vim

TEST_FILES = $(wildcard tests/*.pp)

test: $(NAME)
	for file in $(TEST_FILES); do \
	  puppet apply --modulepath=`pwd`/$(NAME) --noop $$file || exit 1; \
	done

# FIXME: document then remove the no-documentation-check
check: $(NAME)
	puppet-lint --with-filename --fail-on-warnings --no-documentation-check --no-80chars-check vim/manifests/*.pp

# do an ugly symlink so we can rely on the name being known
$(NAME):
	ln -sf . $(NAME)
