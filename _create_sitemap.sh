#!/usr/bin/bash
find . -type f -not -wholename '*/[_.]*' -name '*.html' -printf '\t<url>\n\t\t<loc>%h/%f</loc>\n\t</url>\n' \
	| sed 's/>\./>http:\/\/www.blackle-mori.com/' \
	| cat <(echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">') /dev/stdin <(echo "</urlset>") \
	| sed 's/index.html</</' > sitemap.xml
chmod 755 sitemap.xml
