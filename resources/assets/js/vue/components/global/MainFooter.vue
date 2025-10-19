<template>
    <div class="new-theme">
        <footer>
            <div v-if="shouldFollowUs" class="footer-social very-bold flex">
                <p class="blue-text no-mobile">
                    FOLLOW US
                </p>
                <a href="https://discord.gg/brickbit" target="_blank">
                    <SvgSprite svg="social/discord.svg" />
                </a>
                <a href="https://twitter.com/hillofbricks" target="_blank">
                    <SvgSprite svg="social/twitter.svg" />
                </a>
                <a href="https://www.twitch.tv/hillofbricks" target="_blank">
                    <SvgSprite svg="social/twitch.svg" />
                </a>
                <a
                    href="https://www.youtube.com/c/hillofbricks/"
                    target="_blank"
                >
                    <SvgSprite svg="social/youtube.svg" />
                </a>
                <a
                    href="https://www.instagram.com/hillofbricks/"
                    target="_blank"
                >
                    <SvgSprite svg="social/instagram.svg" />
                </a>
                <a href="https://www.tiktok.com/@hillofbricks" target="_blank">
                    <SvgSprite svg="social/tiktok.svg" />
                </a>
            </div>
            <div class="footer-links flex">
                <a href="/terms">TERMS OF SERVICE</a>
                <a href="/rules">RULES OF CONDUCT</a>
                <a href="/privacy">PRIVACY POLICY</a>
                <a href="/staff">STAFF</a>
                <a href="https://merch.brickbit.net">MERCH STORE</a>
            </div>
            <div class="footer-divider"></div>
            <p class="footer-copyright">
                © {{ new Date().getFullYear() }} BrickBit. All Rights Reserved.
            </p>
        </footer>
    </div>
</template>

<script setup lang="ts">
import { computed } from "vue";
import SvgSprite from "./SvgSprite.vue";

const shouldFollowUs = computed<boolean>(
    () => location.pathname === "/" && document.title === "BrickBit.net"
);
</script>
