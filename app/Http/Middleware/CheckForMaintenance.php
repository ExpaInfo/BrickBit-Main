<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

use Illuminate\Support\Facades\{
    Redis,
    Artisan,
    Cache
};

class CheckForMaintenance
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        // Use Cache instead of Redis directly (works with file or redis driver)
        try {
            $check = Cache::get("maintenance");
            if($check && !app()->isDownForMaintenance()) 
                Artisan::call("down --secret=".config('site.maintenance.key'));            
            if(!$check && app()->isDownForMaintenance())
                Artisan::call("up");
        } catch (\Exception $e) {
            // If cache check fails, just continue - don't break the site
            \Log::warning('Maintenance check failed: ' . $e->getMessage());
        }

        return $next($request);
    }
}
