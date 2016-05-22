#!/bin/bash

dev_dir="/c/Users/Michael/Documents/Projects/MyShoutbox/upload";
install_dir="/c/Users/Michael/Documents/Projects/WebProjects/CityMayhem-Dev";

# Delete existing files
cd "$install_dir";
rm "shoutbox.php";
rm "inc/plugins/myshoutbox.php";
rm "inc/languages/english/myshoutbox.lang.php";
rm "inc/languages/english/admin/myshoutbox.lang.php";
rm "jscripts/myshoutbox.js";

# Install new files
cd "$dev_dir";
cp "shoutbox.php" "$install_dir/";
cp "inc/plugins/myshoutbox.php" "$install_dir/inc/plugins";
cp "inc/languages/english/myshoutbox.lang.php" "$install_dir/inc/languages/english/";
cp "inc/languages/english/admin/myshoutbox.lang.php" "$install_dir/inc/languages/english/admin/";
cp "jscripts/myshoutbox.js" "$install_dir/jscripts";

