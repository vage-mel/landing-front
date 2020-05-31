<template>
  <div class="root" v-if="loaded && content.length">
    <v-container>
      <div class="slider-wrap">
        <transition-group
          :name="transition"
          tag="div"
        >
          <div
            v-for="number in [currentImg]"
            :key="number"
            class="slide slider-content"
          >
            <div class="inner item" :class="[ number % 2 ? 'even' : 'odd' ]">
              <div class="inner-bg">
                <v-row>
                  <v-col md="4" cols="12" class="pa-0">
                    <div class="text">
                      <hidden point="mdUp">
                        <div class="background">
                          <figure>
                            <img :src="content[Math.abs(currentImg) % content.length].image" alt="promotion">
                          </figure>
                        </div>
                      </hidden>
                      <h2 class="use-text-title">
                        <span class="use-text-subtitle2">
                          {{ content[Math.abs(currentImg) % content.length].caption }}
                        </span>
                        SALE
                      </h2>
                      <h4 class="use-text-subtitle">
                        {{ content[Math.abs(currentImg) % content.length].title }}
                      </h4>
                      <article class="desc">
                        <h6 class="use-text-paragraph">
                          {{ content[Math.abs(currentImg) % content.length].desc }}
                        </h6>
                      </article>
                      <v-btn outlined class="button">
                        {{ content[Math.abs(currentImg) % content.length].btn }}
                        <v-icon class="icon-btn">mdi-arrow-right</v-icon>
                      </v-btn>
                      <span
                        class="swipper"
                        v-touch:swipe.left="swipeLeft"
                        v-touch:swipe.right="swipeRight"
                      />
                    </div>
                  </v-col>
                  <v-col md="8" cols="12" class="pa-0">
                    <hidden point="smDown">
                      <div class="image">
                        <figure>
                          <img :src="content[Math.abs(currentImg) % content.length].image" alt="promotion">
                        </figure>
                      </div>
                    </hidden>
                  </v-col>
                </v-row>
              </div>
            </div>
          </div>
        </transition-group>
      </div>
      <a
        href="javascript:void(0)"
        class="prev"
        @click="prev"
      >
        <v-icon class="arrow-icon">mdi-arrow-left</v-icon>
      </a>
      <a
        href="javascript:void(0)"
        class="next"
        @click="next"
      >
        <v-icon class="arrow-icon ">mdi-arrow-right</v-icon>
      </a>
    </v-container>
  </div>
</template>

<style lang="scss" scoped>
@import './promotion-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import Hidden from '../Hidden'
import axios from 'axios'
// const sliderData = [
//   {
//     image: imgAPI.fashion[1]
//   },
//   {
//     image: imgAPI.fashion[2]
//   },
//   {
//     image: imgAPI.fashion[3]
//   },
//   {
//     image: imgAPI.fashion[4]
//   }
// ]

export default {
  components: {
    Hidden
  },
  data() {
    return {
      content: [],
      transition: '',
      autoplay: null,
      currentImg: 0,
      loaded: false
    }
  },
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/promo/`)
    .then((response) => {
      this.content = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
    this.playSlider()
  },
  beforeDestroy() {
    clearInterval(this.autoplay)
  },
  methods: {
    playSlider() {
      this.autoplay = setInterval(() => {
        this.currentImg = this.currentImg + 1
        this.transition = 'slide-right'
      }, 100000)
    },
    manualPlay() {
      clearInterval(this.autoplay)
      setTimeout(() => {
        this.playSlider()
      }, 1)
    },
    next() {
      this.manualPlay()
      this.currentImg += 1
      this.transition = 'slide-right'
    },
    prev() {
      this.manualPlay()
      this.currentImg -= 1
      this.transition = 'slide-left'
    },
    swipeLeft() {
      this.next()
    },
    swipeRight() {
      this.prev()
    }
  }
}
</script>
