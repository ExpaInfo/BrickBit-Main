<?php

namespace App\Http\View\Composers;

use Illuminate\View\View;

use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Cache;

class Banner
{
    /**
     * Bind data to the view.
     *
     * @param  View  $view
     * @return void
     */
    public function compose(View $view)
    {
        try {
            // Try Redis first if available, fallback to cache
            if (extension_loaded('redis')) {
                $banner = Redis::get("site_banner");
                $banner_url = Redis::get("site_banner_url");
            } else {
                $banner = Cache::get("site_banner");
                $banner_url = Cache::get("site_banner_url");
            }
            
            if ($banner) {
                $view->with('site_banner', $banner);
                $view->with('site_banner_url', $banner_url);
            }
        } catch (\Exception $e) {
            // Silently fail - no banner if Redis/cache unavailable
        }
    }
}
