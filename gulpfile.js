var gulp = require('gulp');
var args = require('yargs').argv;
var iconfont = require('gulp-iconfont');
var consolidate = require('gulp-consolidate');

var sourceDir = 'svgs/' + args.font;
var fontName = args.font;
var cssTemplate = 'style';
var htmlTemplate = 'index';
var className = 'icon-' + args.font;
var dist = 'dist/' + args.font;
var tmp = 'tmp/' + args.font;


gulp.task('default', function() {
  gulp.src([sourceDir + '/*.svg'])
    .pipe(iconfont({
      fontName: fontName,
      normalize: true
    }))
    .on('codepoints', function(codepoints) {
      var options = {
        glyphs: codepoints,
        fontName: fontName,
        cssTemplate: cssTemplate,
        className: className
      };
      gulp.src('templates/' + cssTemplate + '.css')
        .pipe(consolidate('lodash', options))
        .pipe(gulp.dest(dist)); // set path to export your CSS
      gulp.src('templates/' + htmlTemplate + '.html')
        .pipe(consolidate('lodash', options))
        .pipe(gulp.dest(dist)); // set path to export your sample HTML
    })
    .pipe(gulp.dest(tmp));
});
