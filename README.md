# Eastbourne Search Ltd - Website Redesign
## Implementation Guide

### Overview
This is a modern, professional single-page website redesign for Eastbourne Search Ltd, a legal title search agency established in 1980.

### Key Features

#### 1. **Modern Color Palette**
- Primary Navy (#1e3a5f) - Professional, trustworthy
- Secondary Blue (#2c5f8d) - Supporting color
- Accent Gold (#c9a961) - Highlights and CTAs
- Light Gray backgrounds for visual hierarchy
- Colors chosen specifically for legal/professional services

#### 2. **Single-Page Design with Anchor Navigation**
- Fixed header with smooth scroll navigation
- Sections: Home, Services, About, Order Forms, Contact
- Each section accessible via anchor links (#home, #services, etc.)

#### 3. **Comprehensive Sections**
- **Hero**: Eye-catching introduction with CTA
- **Services**: Details on title searches offered
- **About**: Why choose Eastbourne Search (40+ years experience)
- **Order Forms**: Download section with placeholder links
- **Contact**: Multiple contact methods clearly displayed

#### 4. **Contact Information**
- Email: search@eastbournesearch.co.nz (preferred method)
- Phone: 0800 22 22 62
- Website: eastbournesearch.co.nz
- Company details: NZBN 9429052008429

#### 5. **Clean HTML5 Code**
- Single HTML file with embedded CSS
- No external dependencies
- Semantic HTML5 elements
- Fully responsive design
- Mobile-optimized

### Important: Order Forms Setup

The download buttons currently have placeholder links. You need to:

1. Create PDF and Word versions of your order form
2. Upload them to your server (suggested location: `/forms/` directory)
3. Update these two lines in the HTML:

```html
<!-- Line ~289 - PDF Form -->
<a href="/forms/eastbourne-search-order-form.pdf" class="download-btn" download>
    📄 Download PDF Order Form
</a>

<!-- Line ~292 - Word Form -->
<a href="/forms/eastbourne-search-order-form.docx" class="download-btn" download>
    📝 Download Word Order Form
</a>
```

Replace the `href="#"` values with your actual file paths.

### Responsive Design
- Desktop: Full navigation, multi-column layouts
- Tablet: Adjusted grid layouts
- Mobile: Single column, optimized font sizes

### Browser Compatibility
- Works in all modern browsers (Chrome, Firefox, Safari, Edge)
- Uses standard HTML5/CSS3 features
- Smooth scroll behavior (gracefully degrades in older browsers)

### Customization Tips

#### Change Colors
All colors are defined in CSS variables at the top of the `<style>` section:
```css
:root {
    --primary-navy: #1e3a5f;
    --secondary-blue: #2c5f8d;
    --accent-gold: #c9a961;
    /* ... etc */
}
```

#### Modify Content
Simply find the relevant section in the HTML and update text, links, or structure.

#### Add New Sections
Follow the existing pattern:
```html
<section id="new-section">
    <div class="container">
        <h2>Section Title</h2>
        <!-- Your content -->
    </div>
</section>
```

Then add to navigation:
```html
<li><a href="#new-section">New Section</a></li>
```

### Deployment
1. Upload `eastbourne-search-redesign.html` to your web server
2. Rename to `index.html` (or your preferred filename)
3. Upload your order form files
4. Update the download links to point to your form files
5. Test all links and anchor navigation
6. Verify mobile responsiveness

### SEO Considerations
- Includes meta description for search engines
- Semantic HTML structure
- Clear heading hierarchy (H1, H2, H3)
- Alt text should be added to any images you include

### Accessibility
- Semantic HTML elements
- Clear color contrast ratios
- Keyboard navigation support
- Screen reader friendly structure

### File Size
- Single HTML file: ~15KB
- No external dependencies
- Fast loading time
- No JavaScript required

### Future Enhancements (Optional)
If you want to add these later:
- Contact form with server-side processing
- Google Maps integration showing office location
- Testimonials section
- FAQ accordion
- Live chat integration
- Google Analytics tracking

### Support
For questions about implementation:
- Email: search@eastbournesearch.co.nz
- Phone: 0800 22 22 62

---

**Design Philosophy**: Professional, trustworthy, and accessible. The color palette conveys legal authority while remaining approachable. Clean layout ensures information is easy to find and digest.