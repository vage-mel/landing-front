<template>
  <div class="root">
    <div class="text-slider" v-if="loaded">
      <h3 class="title-main use-text-title" :class="[ isMobile ? 'text-center' : 'text-left' ]">
        {{ $t('fashionLanding.blog_title') }}
      </h3>
      <div class="carousel">
        <slick
          :options="settingsText"
          ref="sliderText"
          class="slider-text"
        >
          <div
            v-for="(item, index) in blogContent"
            :key="index"
            class="item"
          >
            <h6 class="use-text-title">
              {{ item.name }}
            </h6>
            <p class="use-text-paragraph">
              {{ item.desc }}
            </p>
            <v-btn text class="button">
              {{ $t('fashionLanding.read_more') }}
            </v-btn>
          </div>
        </slick>
      </div>
      <nav>
        <v-btn text class="nav-button prev" @click="slickPrev">
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn>
        <v-btn text class="nav-button next" @click="slickNext">
          <v-icon>mdi-arrow-right</v-icon>
        </v-btn>
      </nav>
    </div>
    <div class="img-slider" v-if="loaded">
      <slick
        :options="settingsImg"
        ref="sliderImage"
        class="slider-image"
      >
        <div
          v-for="(item, index) in blogContent"
          :key="index"
          class="item"
        >
          <v-parallax
            :src="item.img"
            :height="700"
            alt="blog"
          />
        </div>
      </slick>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import './blog-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import axios from 'axios'

// const blogContent = [
//   {
//     img: imgAPI.fashion[30],
//     title: 'Proin lacinia erat ac',
//     desc:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.'
//   },
//   {
//     img: imgAPI.fashion[31],
//     title: 'Proin lacinia erat ac',
//     desc:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.'
//   },
//   {
//     img: imgAPI.fashion[32],
//     title: 'Proin lacinia erat ac',
//     desc:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.'
//   },
//   {
//     img: imgAPI.fashion[33],
//     title: 'Proin lacinia erat ac',
//     desc:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.'
//   },
//   {
//     img: imgAPI.fashion[34],
//     title: 'Proin lacinia erat ac',
//     desc:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.'
//   }
// ]

export default {
  components: {
    Slick: () => import('vue-slick')
  },
  data() {
    return {
      slider: {
        nav1: null,
        nav2: null
      },
      loaded: false,
      blogContent: [],
      settingsImg: {
        dots: false,
        infinite: true,
        speed: 500,
        autoplay: true,
        autoplaySpeed: 10000,
        slidesToShow: 1,
        fade: true,
        arrows: false,
        asNavFor: '.slider-text'
      },
      settingsText: {
        dots: false,
        infinite: true,
        speed: 500,
        autoplay: true,
        autoplaySpeed: 10000,
        slidesToShow: 1,
        pauseOnHover: false,
        arrows: false,
        asNavFor: '.slider-image'
      }
    }
  },
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/blog/`)
    .then((response) => {
      this.blogContent = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
    this.slider = {
      nav1: this.$refs.sliderImage,
      nav2: this.$refs.sliderText
    }
  },
  methods: {
    slickNext() {
      this.$refs.sliderText.next()
    },
    slickPrev() {
      this.$refs.sliderText.prev()
    }
  },
  computed: {
    isMobile() {
      const xsDown = this.$store.state.breakpoints.xsDown
      return xsDown.indexOf(this.$mq) > -1
    }
  }
}
</script>
