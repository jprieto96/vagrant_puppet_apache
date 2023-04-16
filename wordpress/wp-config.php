<?php
define('DB_NAME', 'wp');
define('DB_USER', 'wp');
define('DB_PASSWORD', 'root');
define('DB_HOST', 'localhost');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

define('AUTH_KEY',         '%I9pu:v,.EyO9u&*:]qe7.y}/U#VgN|cK+qA|*{hV/<f6+#4I%g^Qq/jh$oMPA.#');
define('SECURE_AUTH_KEY',  '`}()|s.BqRN7b-[,Y^5?km]A,,/eqQ6h&B]Oj_aeJ#bOx6(-tNiIFweO KZv6m#m');
define('LOGGED_IN_KEY',    '@QH+^|i8nt[X+/ Ij0B1 xp%;(Fub.ta$FS1=*g=~Ybxd44x[(O]V8us^NAiTw6S');
define('NONCE_KEY',        '?R>|b ;fI4xau;ByuGU:WR{( mu4s;Jg[)z5_+D4{<aJ($s#2V;x5KeNfW1~WrL|');
define('AUTH_SALT',        'vob,aOV>w<CBefGk$qT#ksg8uPp{)4=8awY+Qx85b;*{6IM8.}d6Y:pAyM:D0{fD');
define('SECURE_AUTH_SALT', 'aL*:59NJ&D=,5KBSu+Ww?3(nK[Mo|,![My`$xZW)Ie5%gZV4ItlX[3>3}0=/(voq');
define('LOGGED_IN_SALT',   '1jk6C+Xy?MuNMj.d@`9Kv_SeJ5B`GHS@:dud1>%P+G0f||3Q/Bx&u(-ZVk6HzA*O');
define('NONCE_SALT',       '-jPctat^oLI+5/rl{5+Eco!zM&1QcF*~Ba0+8LH<c@59NkE)vuW/;0|A126P4={i');

$table_prefix  = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');