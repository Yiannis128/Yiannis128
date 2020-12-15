module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      boxShadow: {
        "inner-1": 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.1)',
        "inner-2": 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.2)',
        "inner-3": 'inset 0 4px 6px 0 rgba(0, 0, 0, 0.3)'
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
