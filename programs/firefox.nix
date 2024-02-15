{
  inputs,
  userSettings,
  ...
}: {
  home.file."firefox-gnome-theme" = {
    target =
      if (userSettings.dewm == "gnome")
      then ".mozilla/firefox/default/chrome/firefox-gnome-theme"
      else "";
    source = inputs.firefox-gnome-theme;
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        # Betterfox

        /*
                  ***************************************************************************
         * SECTION: FASTFOX                                                         *
        ***************************************************************************
        */
        /*
        * GENERAL **
        */
        "content.notify.interval" = 100000;

        /*
        * GFX **
        */
        "gfx.canvas.accelerated.cache-items" = 4096;
        "gfx.canvas.accelerated.cache-size" = 512;
        "gfx.content.skia-font-cache-size" = 20;

        /*
        * DISK CACHE **
        */
        "browser.cache.jsbc_compression_level" = 3;

        /*
        * MEDIA CACHE **
        */
        "media.memory_cache_max_size" = 65536;
        "media.cache_readahead_limit" = 7200;
        "media.cache_resume_threshold" = 3600;

        /*
        * IMAGE CACHE **
        */
        "image.mem.decode_bytes_at_a_time" = 32768;

        /*
        * NETWORK **
        */
        "network.buffer.cache.size" = 262144;
        "network.buffer.cache.count" = 128;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;
        "network.http.max-urgent-start-excessive-connections-per-host" = 5;
        "network.http.pacing.requests.enabled" = false;
        "network.dnsCacheExpiration" = 3600;
        "network.dns.max_high_priority_threads" = 8;
        "network.ssl_tokens_cache_capacity" = 10240;

        /*
        * SPECULATIVE LOADING **
        */
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;
        "network.predictor.enabled" = false;

        /*
        * EXPERIMENTAL **
        */
        "layout.css.grid-template-masonry-value.enabled" = true;
        "dom.enable_web_task_scheduling" = true;
        "layout.css.has-selector.enabled" = true;
        "dom.security.sanitizer.enabled" = true;

        /*
                  ***************************************************************************
         * SECTION: SECUREFOX                                                       *
        ***************************************************************************
        */
        /*
        * TRACKING PROTECTION **
        */
        "browser.contentblocking.category" = "strict";
        "urlclassifier.trackingSkipURLs" = "*.reddit.com= *.twitter.com= *.twimg.com= *.tiktok.com";
        "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com= *.twitter.com= *.twimg.com";
        "network.cookie.sameSite.noneRequiresSecure" = true;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.helperApps.deleteTempFileOnExit" = true;
        "browser.uitour.enabled" = false;
        "privacy.globalprivacycontrol.enabled" = true;
        "privacy.globalprivacycontrol.functionality.enabled" = true;

        /*
        * OCSP & CERTS / HPKP **
        */
        "security.OCSP.enabled" = 0;
        "security.remote_settings.crlite_filters.enabled" = true;
        "security.pki.crlite_mode" = 2;

        /*
        * SSL / TLS **
        */
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "browser.xul.error_pages.expert_bad_cert" = true;
        "security.tls.enable_0rtt_data" = false;

        /*
        * DISK AVOIDANCE **
        */
        "browser.privatebrowsing.forceMediaMemoryCache" = true;
        "browser.sessionstore.interval" = 60000;

        /*
        * SHUTDOWN & SANITIZING **
        */
        "privacy.history.custom" = true;

        /*
        * SEARCH / URL BAR **
        */
        "browser.search.separatePrivateDefault.ui.enabled" = true;
        "browser.urlbar.update2.engineAliasRefresh" = true;
        "browser.search.suggest.enabled" = true;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.formfill.enable" = false;
        "security.insecure_connection_text.enabled" = true;
        "security.insecure_connection_text.pbmode.enabled" = true;
        "network.IDN_show_punycode" = true;

        /*
        * HTTPS-FIRST POLICY **
        */
        "dom.security.https_first" = true;

        /*
        * PASSWORDS **
        */
        "signon.rememberSignons" = false;
        "signon.formlessCapture.enabled" = false;
        "signon.privateBrowsingCapture.enabled" = false;
        "network.auth.subresource-http-auth-allow" = 1;
        "editor.truncate_user_pastes" = false;

        /*
        * ADDRESS + CREDIT CARD MANAGER **
        */
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        /*
        * MIXED CONTENT + CROSS-SITE **
        */
        "security.mixed_content.block_display_content" = true;
        "security.mixed_content.upgrade_display_content" = true;
        "security.mixed_content.upgrade_display_content.image" = true;
        "pdfjs.enableScripting" = false;
        "extensions.postDownloadThirdPartyPrompt" = false;

        /*
        * HEADERS / REFERERS **
        */
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        /*
        * CONTAINERS **
        */
        "privacy.userContext.ui.enabled" = true;

        /*
        * WEBRTC **
        */
        "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
        "media.peerconnection.ice.default_address_only" = true;

        /*
        * SAFE BROWSING **
        */
        "browser.safebrowsing.downloads.remote.enabled" = false;

        /*
        * MOZILLA **
        */
        "permissions.default.desktop-notification" = 2;
        "permissions.default.geo" = 2;
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "permissions.manager.defaultsUrl" = "";
        "webchannel.allowObject.urlWhitelist" = "";

        /*
        * TELEMETRY **
        */
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:=";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;

        /*
        * EXPERIMENTS **
        */
        "app.shield.optoutstudies.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";

        /*
        * CRASH REPORTS **
        */
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;

        /*
        * DETECTION **
        */
        "captivedetect.canonicalURL" = "";
        "network.captive-portal-service.enabled" = false;
        "network.connectivity-service.enabled" = false;

        /*
          ***************************************************************************
         * SECTION: PESKYFOX                                                        *
        ***************************************************************************
        */
        /*
        * MOZILLA UI **
        */
        "browser.privatebrowsing.vpnpromourl" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "browser.discovery.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.preferences.moreFromMozilla" = false;
        "browser.tabs.tabmanager.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;

        /*
        * THEME ADJUSTMENTS **
        */
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;
        "browser.display.focus_ring_on_anything" = true;
        "browser.display.focus_ring_style" = 0;
        "browser.display.focus_ring_width" = 0;
        "layout.css.prefers-color-scheme.content-override" = 2;
        "browser.privateWindowSeparation.enabled" = false;

        /*
        * COOKIE BANNER HANDLING **
        */
        "cookiebanners.service.mode" = 1;
        "cookiebanners.service.mode.privateBrowsing" = 1;
        "cookiebanners.service.enableGlobalRules" = true;

        /*
        * FULLSCREEN NOTICE **
        */
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.delay" = -1;
        "full-screen-api.warning.timeout" = 0;

        /*
        * URL BAR **
        */
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trending.featureGate" = false;

        /*
        * NEW TAB PAGE **
        */
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        /*
        * POCKET **
        */
        "extensions.pocket.enabled" = false;

        /*
        * DOWNLOADS **
        */
        "browser.download.useDownloadDir" = false;
        "browser.download.always_ask_before_handling_new_types" = true;
        "browser.download.manager.addToRecentDocs" = false;

        /*
        * PDF **
        */
        "browser.download.open_pdf_attachments_inline" = true;

        /*
        * TAB BEHAVIOR **
        */
        "browser.bookmarks.openInTabClosesMenu" = false;
        "browser.menu.showViewImageInfo" = true;
        "findbar.highlightAll" = true;
        "layout.word_select.eat_space_to_next_word" = false;

        # Personal
        "browser.tabs.loadInBackground" = true;

        # Theming
        "svg.context-properties.content.enabled" = true;
        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
        "browser.toolbars.bookmarks.visibility" = "never";

        # Smoothfox
        "apz.overscroll.enabled" = true;
        "general.smoothScroll" = true;
        "mousewheel.default.delta_multiplier_y" = 275;
      };
      userChrome =
        if (userSettings.dewm == "gnome")
        then
          /*
          css
          */
          ''
                          @import "firefox-gnome-theme/userChrome.css";
                          :root {    --gnome-window-background:                     rgb(30, 30, 46);
                      --gnome-browser-before-load-background:        rgb(30, 30, 46);
                      --gnome-accent-bg:                             rgb(137, 180, 250);
                      --gnome-accent:                                rgb(116, 199, 236);
                      --gnome-toolbar-background:                    rgb(30, 30, 46);
                      --gnome-toolbar-color:                         rgb(205, 214, 244);
                      --gnome-toolbar-icon-fill:                     rgb(205, 214, 244);
                      --gnome-inactive-toolbar-color:                rgb(30, 30, 46);
                      --gnome-inactive-toolbar-border-color:         rgb(49, 50, 68);
                      --gnome-inactive-toolbar-icon-fill:            rgb(205, 214, 244);
                      --gnome-menu-background:                       rgb(24, 24, 37);
                      --gnome-headerbar-background:                  rgb(17, 17, 27);
                      --gnome-button-destructive-action-background:  rgb(237, 135, 160);
                      --gnome-entry-color:                           rgb(205, 214, 244);
                      --gnome-inactive-entry-color:                  rgb(205, 214, 244);
                      --gnome-switch-slider-background:              rgb(24, 24, 37);
                      --gnome-switch-active-slider-background:       rgb(116, 199, 236);
                      --gnome-inactive-tabbar-tab-background:        rgb(30, 30, 46);
                      --gnome-inactive-tabbar-tab-active-background: rgba(255,255,255,0.025);
                      --gnome-tabbar-tab-background:                 rgb(30, 30, 46);
                      --gnome-tabbar-tab-hover-background:           rgba(255,255,255,0.025);
                      --gnome-tabbar-tab-active-background:          rgba(255,255,255,0.075);
                      --gnome-tabbar-tab-active-hover-background:    rgba(255,255,255,0.100);
                      --gnome-tabbar-tab-active-background-contrast: rgba(255,255,255,0.125);}

                      @-moz-document url-prefix(about:home), url-prefix(about:newtab) {
             body{
              --newtab-background-color: #2A2A2E!important;
              --newtab-border-primary-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-border-secondary-color: rgba(249, 249, 250, 0.1)!important;
              --newtab-button-primary-color: #0060DF!important;
              --newtab-button-secondary-color: #38383D!important;
              --newtab-element-active-color: rgba(249, 249, 250, 0.2)!important;
              --newtab-element-hover-color: rgba(249, 249, 250, 0.1)!important;
              --newtab-icon-primary-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-icon-secondary-color: rgba(249, 249, 250, 0.4)!important;
              --newtab-icon-tertiary-color: rgba(249, 249, 250, 0.4)!important;
              --newtab-inner-box-shadow-color: rgba(249, 249, 250, 0.2)!important;
              --newtab-link-primary-color: var(--gnome-accent)!important;
              --newtab-link-secondary-color: #50BCB6!important;
              --newtab-text-conditional-color: #F9F9FA!important;
              --newtab-text-primary-color: var(--gnome-accent)!important;
              --newtab-text-secondary-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-textbox-background-color: var(--gnome-toolbar-background)!important;
              --newtab-textbox-border: var(--gnome-inactive-toolbar-border-color)!important;
              --newtab-textbox-focus-color: #45A1FF!important;
              --newtab-textbox-focus-boxshadow: 0 0 0 1px #45A1FF, 0 0 0 4px rgba(69, 161, 255, 0.3)!important;
              --newtab-feed-button-background: #38383D!important;
              --newtab-feed-button-text: #F9F9FA!important;
              --newtab-feed-button-background-faded: rgba(56, 56, 61, 0.6)!important;
              --newtab-feed-button-text-faded: rgba(249, 249, 250, 0)!important;
              --newtab-feed-button-spinner: #D7D7DB!important;
              --newtab-contextmenu-background-color: #4A4A4F!important;
              --newtab-contextmenu-button-color: #2A2A2E!important;
              --newtab-modal-color: #2A2A2E!important;
              --newtab-overlay-color: rgba(12, 12, 13, 0.8)!important;
              --newtab-section-header-text-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-section-navigation-text-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-section-active-contextmenu-color: #FFF!important;
              --newtab-search-border-color: rgba(249, 249, 250, 0.2)!important;
              --newtab-search-dropdown-color: #38383D!important;
              --newtab-search-dropdown-header-color: #4A4A4F!important;
              --newtab-search-header-background-color: rgba(42, 42, 46, 0.95)!important;
              --newtab-search-icon-color: rgba(249, 249, 250, 0.6)!important;
              --newtab-search-wordmark-color: #FFF!important;
              --newtab-topsites-background-color: #38383D!important;
              --newtab-topsites-icon-shadow: none!important;
              --newtab-topsites-label-color: rgba(249, 249, 250, 0.8)!important;
              --newtab-card-active-outline-color: var(--gnome-toolbar-icon-fill)!important;
              --newtab-card-background-color: var(--gnome-toolbar-background)!important;
              --newtab-card-hairline-color: rgba(249, 249, 250, 0.1)!important;
              --newtab-card-placeholder-color: #4A4A4F!important;
              --newtab-card-shadow: 0 1px 8px 0 rgba(12, 12, 13, 0.2)!important;
              --newtab-snippets-background-color: #38383D!important;
              --newtab-snippets-hairline-color: rgba(255, 255, 255, 0.1)!important;
              --trailhead-header-text-color: rgba(255, 255, 255, 0.6)!important;
              --trailhead-cards-background-color: rgba(12, 12, 13, 0.1)!important;
              --trailhead-card-button-background-color: rgba(12, 12, 13, 0.3)!important;
              --trailhead-card-button-background-hover-color: rgba(12, 12, 13, 0.5)!important;
              --trailhead-card-button-background-active-color: rgba(12, 12, 13, 0.7)!important;
             }
            }
          ''
        else "";
      userContent =
        if (userSettings.dewm == "gnome")
        then
          /*
          css
          */
          ''
            @import "firefox-gnome-theme/userContent.css";
          ''
        else "";
    };
  };
}
