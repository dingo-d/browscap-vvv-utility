#!/usr/bin/env bash

copy_browscap() {
  # Remove any existing copies of the ini file and copy new one
  rm "/etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini"
  touch "/etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini"
  cp "lite_php_browscap.ini" "/etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini"
  echo "Lite Browscap copied"
}

echo "Setting up Lite Browsecap"

# Check PHP version
PHP_VER=`php -r \@phpinfo\(\)\; | grep 'PHP Version' -m 1 | grep -Po -m 1 '(\d+\.\d+)' | head -1`
MIN_REQ="5.3"

if (( $(echo "${PHP_VER} < ${MIN_REQ}" |bc -l) )); then
  echo "The PHP version is lower than 5.3 so browscap won't work. Please upgrade your PHP version to higher than 5.3"
  exit 0
fi
echo "PHP version is" ${PHP_VER}

# Check if browscap is already installed/set up
if [[ -s "/etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini" ]]; then
  echo "Lite Browscap is already installed"
  copy_browscap
else
  copy_browscap
fi

# Check if php.ini exists before replacing
if [[ -f "/etc/php/${PHP_VER}/fpm/php.ini" ]]; then
  echo "php.ini exists"
  # Check if the default value exists - by default it should be ;browscap = extra/browscap.ini
  # If it doesn't then find browscap = and replace it with the correct one
  if grep -q ";browscap" "/etc/php/${PHP_VER}/fpm/php.ini"; then
    sudo sed -i "s|;browscap =.*|browscap = /etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini|g" "/etc/php/${PHP_VER}/fpm/php.ini"
  else
    sudo sed -i "s|browscap =.*|browscap = /etc/php/${PHP_VER}/mods-available/lite_php_browscap.ini|g" "/etc/php/${PHP_VER}/fpm/php.ini"
  fi
  echo "php.ini changed"
else
  echo "php.ini doesn't exist"
fi
