<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;

use Illuminate\Support\Facades\Session;

class SessionServiceProvider extends ServiceProvider
{
    public $bindings = [
        \Illuminate\Session\Middleware\StartSession::class => \App\Extensions\Session\StartSessionTTL::class,
    ];

    /**
     * Register services.
     *
     * @return void
     */
    public function register()
    {
        Session::extend('cachettl', function ($app) {
            $container = $app->make(\Illuminate\Contracts\Container\Container::class);
            // Use file cache instead of Redis when Redis is not available
            $store = config('session.store') ?: 'file';
            try {
                $cache = clone $container->make('cache')->store($store);
                if ($store === 'redis') {
                    $cache->setConnection(config('session.connection'));
                }
            } catch (\Exception $e) {
                // Fallback to file cache if Redis fails
                $cache = clone $container->make('cache')->store('file');
            }

            $handler = new \App\Extensions\Session\CacheBasedSessionHandler(
                $cache,
                config('session.lifetime')
            );

            return $handler;
        });
    }

    /**
     * Bootstrap services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
