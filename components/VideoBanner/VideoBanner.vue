<template>
  <div class="root">
    <div class="video" v-if="loaded && content.length">
      <div class="overlay" />
      <img v-if="!play || isMobile" :src="content[0].img" alt="cover" />
      <div v-if="yt.use">
        <youtube
          v-if="isDesktop"
          :video-id="content[0].youtube_video_id"
          :player-vars="playerVars"
          :width= "1080"
          :height="720"
          ref="youtube"
          @playing="playing"
          @ended="ended"
        />
      </div>
      <div class="caption">
        <v-container class="max-md">
          <hidden point="mdDown">
            <v-btn
              v-if="play"
              icon
              class="btn-play"
              @click="togglePause()"
            >
              <i v-if="playCtrl" class="ion-ios-pause-outline" />
              <i v-else class="ion-ios-play-outline" />
            </v-btn>
          </hidden>
          <h6 class="use-text-subtitle">
            {{ content[0].subtitle }}
          </h6>
          <h2 class="use-text-title">{{ content[0].title }}</h2>
          <scrollactive v-if="loaded" :offset="100">
            <v-btn icon large class="arrow anchor-link scrollactive-item" href="#promotions">
              <v-icon>mdi-arrow-down</v-icon>
            </v-btn>
          </scrollactive>
        </v-container>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import './banner-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import youtube from '~/youtube'
import Hidden from '../Hidden'
import axios from 'axios'

export default {
  components: {
    Hidden
  },
  data() {
    return {
      loaded: false,
      playerVars: {
        autoplay: 1,
        controls: 0,
        rel: 0,
        showinfo: 0,
        mute: 1,
        origin: 'http://localhost:8004'
      },
      yt: youtube,
      play: false,
      playCtrl: true,
    }
  },
  mounted() {
    axios.get(`${process.env.backendUrl}/api/landing/main-block/`)
    .then((response) => {
      this.content = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  methods: {
    playing() {
      this.play = true
      this.playCtrl = true
    },
    ended() {
      this.player.playVideo()
    },
    togglePause() {
      this.playCtrl = !this.playCtrl
      if (this.playCtrl) {
        this.player.playVideo()
      } else {
        this.player.pauseVideo()
      }
    }
  },
  computed: {
    player() {
      return this.$refs.youtube.player
    },
    isDesktop() {
      const lgUp = this.$store.state.breakpoints.lgUp
      return lgUp.indexOf(this.$mq) > -1
    },
    isMobile() {
      const mdDown = this.$store.state.breakpoints.mdDown
      return mdDown.indexOf(this.$mq) > -1
    }
  }
}
</script>
