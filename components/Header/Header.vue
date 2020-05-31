<template>
  <fragment>
    <v-navigation-drawer
      v-if="isMobile"
      v-model="openDrawer"
      fixed
      temporary
      class="mobile-nav"
    >
      <mobile-menu :open="openDrawer" />
    </v-navigation-drawer>
    <v-app-bar
      v-scroll="handleScroll"
      id="header"
      :class="{ fixed: fixed, 'open-drawer': openDrawer }"
      class="header"
      fixed
      app
    >
      <v-container :class="{ 'fixed-width': isDesktop }" v-if="loaded && menuList.length">
        <div class="header-content">
          <nav
            :class="{ invert: invert }"
            class="nav-menu"
          >
            <v-btn
              v-if="isMobile"
              :class="{ 'is-active': openDrawer }"
              class="hamburger hamburger--spin mobile-menu"
              text
              icon
              @click.stop="handleToggleOpen"
            >
              <span class="hamburger-box">
                <span class="bar hamburger-inner" />
              </span>
            </v-btn>
            <div class="logo">
              <nuxt-link
                v-if="invert"
                :to="link.fashion.home"
              >
                <img
                  :src="logo"
                  alt="logo"
                >
              </nuxt-link>
              <scrollactive
                v-if="!invert && loaded"
                tag="span"
              >
                <a
                  href="#home"
                  class="anchor-link scrollactive-item"
                >
                  <img
                    :src="logo"
                    alt="logo"
                  >
                </a>
              </scrollactive>
            </div>
            <div v-if="isDesktop">
              <scrollactive
                v-if="loaded"
                :offset="navOffset"
                active-class="active"
                tag="ul"
              >
                <li
                  v-for="(item, index) in menuList"
                  :key="index"
                >
                  <v-btn
                    v-if="!invert"
                    :href="item.url"
                    class="anchor-link scrollactive-item"
                    text
                    @click="setOffset(item.offset)"
                  >
                    {{ item.name }}
                  </v-btn>
                  <v-btn
                    v-if="invert"
                    :href="'/' + item.url"
                    text
                  >
                    {{ item.name }}
                  </v-btn>
                </li>
              </scrollactive>
            </div>
          </nav>
          <nav>
            <setting-menu :invert="invert" />
          </nav>
        </div>
      </v-container>
    </v-app-bar>
  </fragment>
</template>

<style lang="scss" scoped>
@import './header-style.scss';
</style>

<script>
import logo from '~/static/images/fashion-logo.svg'
import link from '~/static/text/link'
import brand from '~/static/text/brand'
// import navMenu from './menu'
import Settings from './Settings'
import MobileMenu from './MobileMenu'
import axios from 'axios'

let counter = 0
function createData(name, url, offset) {
  counter += 1
  return {
    id: counter,
    name,
    url,
    offset
  }
}

export default {
  components: {
    'setting-menu': Settings,
    MobileMenu
  },
  props: {
    invert: {
      type: Boolean,
      default: false
    }
  },
  data() {
    return {
      logo: logo,
      link: link,
      loaded: false,
      brand: brand,
      section: 0,
      fixed: false,
      openDrawer: null,
      navOffset: 20,
      menuList: [
        // createData(navMenu[0], '#' + navMenu[0]),
        // createData(navMenu[1], '#' + navMenu[1]),
        // createData(navMenu[2], '#' + navMenu[2]),
        // createData(navMenu[3], '#' + navMenu[3]),
        // createData(navMenu[4], '#' + navMenu[4]),
        // createData(navMenu[5], '#' + navMenu[5])
      ]
    }
  },
  mounted() {
    axios.get(`${process.env.backendUrl}/api/landing/menu/`)
    .then((response) => {
      this.menuList = response.data
      this.menuList = this.menuList.map(function (item) {
        return createData(item.name, item.link)
      })
    })
    .catch((e) => {
      console.log(e)
    })
    .finally(() => {
      this.loaded = true
    })
  },
  methods: {
    handleScroll: function() {
      if (window.scrollY > 80) {
        return (this.fixed = true)
      }
      return (this.fixed = false)
    },
    setOffset: function(offset) {
      this.navOffset = offset
    },
    handleToggleOpen: function() {
      this.openDrawer = !this.openDrawer
    }
  },
  computed: {
    isMobile() {
      const smDown = this.$store.state.breakpoints.smDown
      return smDown.indexOf(this.$mq) > -1
    },
    isDesktop() {
      const mdUp = this.$store.state.breakpoints.mdUp
      return mdUp.indexOf(this.$mq) > -1
    }
  }
}
</script>
