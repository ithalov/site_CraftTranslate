/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html', './src/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        bg: 'var(--color-bg)',
        bgElevated: 'var(--color-bg-elevated)',
        surface: 'var(--color-surface)',
        surface2: 'var(--color-surface-2)',
        line: 'var(--color-line)',
        text: 'var(--color-text)',
        muted: 'var(--color-muted)',
        accent: 'var(--color-accent)',
        accent2: 'var(--color-accent-2)',
        success: 'var(--color-success)',
        warning: 'var(--color-warning)',
        danger: 'var(--color-danger)',
        ink: { 950: '#101114' }
      },
      boxShadow: {
        glow: '8px 8px 0 #101114',
        soft: '6px 6px 0 #101114'
      },
      borderRadius: {
        xl2: '0'
      }
    }
  },
  plugins: []
};
