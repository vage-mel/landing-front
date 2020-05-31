<template>
  <div class="root">
    <div class="img-slider" v-if="loaded">
      <slick
        :options="settingsImg"
        class="slider-image"
        ref="sliderImage"
      >
        <div
          v-for="(item, index) in testiContent"
          :key="index"
          class="item"
        >
          <v-parallax
            :src="item.img"
            :height="700"
            alt="testimonial"
          />
        </div>
      </slick>
    </div>
    <div class="text-slider" v-if="loaded">
      <v-icon class="icon">mdi-format-quote-close</v-icon>
      <nav>
        <v-btn text class="nav-button prev" @click="slickPrev">
          <v-icon>mdi-arrow-left</v-icon>
        </v-btn>
        <v-btn text class="nav-button next" @click="slickNext">
          <v-icon>mdi-arrow-right</v-icon>
        </v-btn>
      </nav>
      <div>
        <h3 class="title-main use-text-title">
          {{ $t('fashionLanding.testimonial_title') }}
        </h3>
        <div class="carousel">
          <slick
            :options="settingsText"
            ref="sliderText"
            class="slider-text"
          >
            <div
              v-for="(item, index) in testiContent"
              :key="index"
              class="item"
            >
              <p class="use-text-paragraph">
                {{ item.text }}
              </p>
              <v-divider class="divider" />
              <h6 class="use-text-subtitle2">
                {{ item.name }}
              </h6>
              <p class="use-text-paragraph">
                {{ item.title }}
              </p>
            </div>
          </slick>
        </div>
      </div>
    </div>
  </div>
</template>

<style lang="scss" scoped>
@import './testi-style.scss';
</style>

<script>
import imgAPI from '~/static/images/imgAPI'
import axios from 'axios'

// const testiContent = [
//   {
//     text:
//       'Vivamus sit amet interdum elit. Proin lacinia erat ac velit tempus auctor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Aliquam nec ex aliquet, aliquam neque non.',
//     img: imgAPI.fashion[26],
//     name: 'John Doe',
//     title: 'Chief Digital Officer'
//   },
//   {
//     text:
//       'Vestibulum sit amet tortor sit amet libero lobortis semper at et odio. In eu tellus tellus. Pellentesque ullamcorper aliquet ultrices. Aenean facilisis vitae purus facilisis semper. Nam vitae scelerisque lorem, quis tempus libero.',
//     img: imgAPI.fashion[27],
//     name: 'Jean Doe',
//     title: 'Chief Digital Officer'
//   },
//   {
//     text:
//       'Cras convallis lacus orci, tristique tincidunt magna consequat in. In vel pulvinar est, at euismod libero.',
//     img: imgAPI.fashion[28],
//     name: 'Jena Doe',
//     title: 'Graphic Designer'
//   },
//   {
//     text:
//       'Sed imperdiet enim ligula, vitae viverra justo porta vel.',
//     img: imgAPI.fashion[29],
//     name: 'Jovelin Doe',
//     title: 'Senior Graphic Designer'
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
      testiContent: [],
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
    axios.get(`${process.env.backendUrl}/api/landing/testimonial/`)
    .then((response) => {
      this.testiContent = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  methods: {
    slickNext() {
      this.$refs.sliderText.next()
    },
    slickPrev() {
      this.$refs.sliderText.prev()
    }
  }
}
</script>
