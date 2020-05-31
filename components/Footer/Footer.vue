<template>
  <footer class="root">
    <v-container class="max-lg">
      <div class="logo">
        <img :src="logo" alt="logo" />
      </div>
      <div class="subscribe">
        <h5 class="use-text-subtitle">
          {{ $t('fashionLanding.subscribe_title') }}
        </h5>
        <div class="form">
          <form>
            <v-text-field
              :placeholder="$t('fashionLanding.subscribe_email')"
              class="field"
              full-width
            />
            <v-btn text class="button">
              {{ $t('fashionLanding.subscribe_button') }}
            </v-btn>
          </form>
        </div>
      </div>
      <nav v-if="loaded && menu.length">
        <ul>
          <li
            v-for="(item, index) in menu"
            :key="index"
          >
            <a :href="'#' + item.link">
              {{ item.name }}
            </a>
          </li>
        </ul>
      </nav>
      <div class="socmed">
        <v-btn icon small class="icon">
          <i class="ion-social-twitter" />
        </v-btn>
        <v-btn icon small class="icon">
          <i class="ion-social-facebook" />
        </v-btn>
        <v-btn icon small class="icon">
          <i class="ion-social-instagram" />
        </v-btn>
      </div>
    </v-container>
    <div class="copyright">
      <p class="body-2 text-center">
        &copy;
        {{ brand.fashion.footerText }}
      </p>
    </div>
  </footer>
</template>

<style scoped lang="scss">
@import './footer-style';
</style>

<script>
import logo from '~/static/images/fashion-logo.svg'
import brand from '~/static/text/brand'
// import menu from '../Header/menu'
import axios from 'axios'

export default {
  data: () => ({
    logo: logo,
    brand: brand,
    menu: [],
    loaded: false
  }),
  mounted() {
    axios.get(`http://127.0.0.1:8000/api/landing/menu/`)
    .then((response) => {
      this.menu = response.data
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
}
</script>
