{*
 * WiND - Wireless Nodes Database
 * Modern UI
 *}
<!doctype html>
<html lang="{$lang.iso639}">
<head>
        <meta charset="{$lang.charset}"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="theme-color" content="#0f172a">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
        <script type="text/javascript" src="{$js_dir}/jquery-1.9.1.js"></script>
        <script type="text/javascript" src="{$js_dir}/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript" src="{$js_dir}/ui.js"></script>
        <script type="text/javascript" src="{$tpl_dir}/static/bootstrap/js/bootstrap.min.js"></script>
        {$head}
        <link href="{$css_dir}/jquery-ui/jquery-ui.min.css" rel="stylesheet"/>
        <link href="{$tpl_dir}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
        <link href="{$css_dir}/styles.css" rel="stylesheet"/>
        <link href="{$css_dir}/map.css" rel="stylesheet"/>
        <link rel="icon" type="image/png" href="{$img_dir}/favicon_32.png" />
</head>
<body{foreach from=$body_tags item=item key=key} {$key}="{$item}"{/foreach}>
<div id="overDiv" style="position:absolute; visibility:hidden; z-index:1000;"></div>
{$body}
</body>
</html>
