<?php

namespace App\Http\Middleware\Laravel;

use Closure;

class Https
{
    protected $except = [
        '/API/client/*',
        '/API/games/*',
        '/download/*',
        '/v1/auth/verifyToken',
        '/v1/games/retrieveAsset',
        '/v1/alb/healthcheck'
    ];

    public function handle($request, Closure $next)
    {
        // Check if behind a load balancer (like DigitalOcean App Platform)
        // Load balancers terminate SSL, so we need to check X-Forwarded-Proto header
        $isSecure = $request->secure() || $request->header('X-Forwarded-Proto') === 'https';
        
        if (!$isSecure && !$this->inExceptArray($request) && (app()->environment() != 'local' && app()->environment() != 'testing')) {
            return redirect()->secure($request->getRequestUri());
        }

        return $next($request);
    }

    protected function inExceptArray($request)
    {
        foreach ($this->except as $except) {
            if ($except !== '/') {
                $except = trim($except, '/');
            }

            if ($request->fullUrlIs($except) || $request->is($except)) {
                return true;
            }
        }

        return false;
    }
}
