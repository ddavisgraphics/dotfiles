# // Stole this from Sean Lawrenz
# // build emperor first yarn build:libs. then test-emperor terminal and it should work from there.
# // You may need to reset cache on terminal by rm -rf .angular/cache

BOLD_PENGUIN_DIR=$APP

function remove-emperor {
  REPO=$1

  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-form-fields
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-services
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-icons
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-sdk-wrapper
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-presentational
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-styles
  rm -rf \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-features
}

function copy-emperor {
  REPO=$1

	cp -r \
		$BOLD_PENGUIN_DIR/emperor/dist/libs/form-fields \
	  $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-form-fields

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/services \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-services

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/icons \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-icons

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/sdk-wrapper \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-sdk-wrapper

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/presentational \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-presentational

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/styles \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-styles

    cp -r \
    $BOLD_PENGUIN_DIR/emperor/dist/libs/features \
    $BOLD_PENGUIN_DIR/$REPO/node_modules/@boldpenguin/emperor-features

	echo 'DONE'

}

function test-emperor {
  REPO=$1

  remove-emperor $REPO
  copy-emperor $REPO

}
