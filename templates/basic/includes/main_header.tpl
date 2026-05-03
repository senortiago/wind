{*
 * WiND - Wireless Nodes Database
 * Modern header
 *}
        <a href="{$link_home}">
{if $mylogo}
                <img src="{$mylogo_dir}/mylogo.png" alt="Logo" style="height:36px;" />
{else}
                <img src="{$img_dir}/main_logo.png" alt="WiND" style="height:36px;" />
{/if}
        </a>

        <div class="user-panel">
                {include file="generic/language_selection.tpl" languages=$languages current_language=$current_language}

                <div class="quicksearch">
                        <form name="search" method="get" action="{$search_url}">
                                <input placeholder="&#x1F50D; Search nodes..." type="text" id="q" name="q" autocomplete="off"
                                        onkeydown="" onfocus="hover('',this.value);" onkeyup="hover(event.keyCode,this.value);"
                                        onblur="setTimeout('hideSearch()',500); hov=0;" />
                                <div id="searchResult"></div>
                        </form>
                </div>

        {if $logged==TRUE}
                <a href="{$link_user_profile|escape}" class="user">&#x1F464; {$logged_title}</a>
                <a id="logout" href="{$link_logout|escape}" class="logout">{$lang.logout}</a>
        {else}
                <a id="login" href="{$link_login_form|escape}">{$lang.login}</a>
                <a href="{$link_register|escape}" style="color:#94a3b8;font-size:12px;">{$lang.register}</a>
        {/if}
        </div>

        {literal}
        <script>
        $(function(){
                var login_form = new LoginForm({/literal} '{$link_login_form|escape}' {literal});
                $('#login').click(function() {
                        login_form.show();
                        return false;
                });
                $('#logout').click(function() {
                        $.get($(this).attr('href'), function(){
                                reload();
                        });
                        return false;
                });
        });
        </script>
        {/literal}
