/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _blots_image_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(1);
/* harmony import */ var _quill_imageUploader_css__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(3);
/* harmony import */ var _quill_imageUploader_css__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_quill_imageUploader_css__WEBPACK_IMPORTED_MODULE_1__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }




var ImageUploader = function () {
  function ImageUploader(quill, options) {
    _classCallCheck(this, ImageUploader);

    this.quill = quill;
    this.options = options;
    this.range = null;

    if (typeof this.options.upload !== "function") {
      console.warn("[Missing config] upload function that returns a promise is required");
    }

    if (this.options.loadingClass) {
      _blots_image_js__WEBPACK_IMPORTED_MODULE_0__["default"].className = this.options.loadingClass;
    }

    var toolbar = this.quill.getModule("toolbar");
    toolbar.addHandler("image", this.selectLocalImage.bind(this));

    this.handleDrop = this.handleDrop.bind(this);
    this.handlePaste = this.handlePaste.bind(this);

    this.quill.root.addEventListener("drop", this.handleDrop, false);
    this.quill.root.addEventListener("paste", this.handlePaste, false);
  }

  _createClass(ImageUploader, [{
    key: "selectLocalImage",
    value: function selectLocalImage() {
      var _this = this;

      this.range = this.quill.getSelection();
      this.fileHolder = document.createElement("input");
      this.fileHolder.setAttribute("type", "file");
      this.fileHolder.setAttribute("accept", "image/*");
      this.fileHolder.setAttribute("style", "visibility:hidden");

      this.fileHolder.onchange = this.fileChanged.bind(this);

      document.body.appendChild(this.fileHolder);

      this.fileHolder.click();

      window.requestAnimationFrame(function () {
        document.body.removeChild(_this.fileHolder);
      });
    }
  }, {
    key: "handleDrop",
    value: function handleDrop(evt) {
      var _this2 = this;

      evt.stopPropagation();
      evt.preventDefault();
      if (evt.dataTransfer && evt.dataTransfer.files && evt.dataTransfer.files.length) {
        if (document.caretRangeFromPoint) {
          var selection = document.getSelection();
          var range = document.caretRangeFromPoint(evt.clientX, evt.clientY);
          if (selection && range) {
            selection.setBaseAndExtent(range.startContainer, range.startOffset, range.startContainer, range.startOffset);
          }
        } else {
          var _selection = document.getSelection();
          var _range = document.caretPositionFromPoint(evt.clientX, evt.clientY);
          if (_selection && _range) {
            _selection.setBaseAndExtent(_range.offsetNode, _range.offset, _range.offsetNode, _range.offset);
          }
        }

        this.range = this.quill.getSelection();
        var file = evt.dataTransfer.files[0];

        setTimeout(function () {
          _this2.range = _this2.quill.getSelection();
          _this2.readAndUploadFile(file);
        }, 0);
      }
    }
  }, {
    key: "handlePaste",
    value: function handlePaste(evt) {
      var _this3 = this;

      var clipboard = evt.clipboardData || window.clipboardData;

      // IE 11 is .files other browsers are .items
      if (clipboard && (clipboard.items || clipboard.files)) {
        var items = clipboard.items || clipboard.files;
        var IMAGE_MIME_REGEX = /^image\/(jpe?g|gif|png|svg|webp)$/i;

        for (var i = 0; i < items.length; i++) {
          if (IMAGE_MIME_REGEX.test(items[i].type)) {
            (function () {
              var file = items[i].getAsFile ? items[i].getAsFile() : items[i];

              if (file) {
                _this3.range = _this3.quill.getSelection();
                evt.preventDefault();
                setTimeout(function () {
                  _this3.range = _this3.quill.getSelection();
                  _this3.readAndUploadFile(file);
                }, 0);
              }
            })();
          }
        }
      }
    }
  }, {
    key: "readAndUploadFile",
    value: function readAndUploadFile(file) {
      var _this4 = this;

      var isUploadReject = false;

      var fileReader = new FileReader();

      fileReader.addEventListener("load", function () {
        if (!isUploadReject) {
          var base64ImageSrc = fileReader.result;
          _this4.insertBase64Image(base64ImageSrc);
        }
      }, false);

      if (file) {
        fileReader.readAsDataURL(file);
      }

      this.options.upload(file).then(function (imageUrl) {
        _this4.insertToEditor(imageUrl);
      }, function (error) {
        isUploadReject = true;
        _this4.removeBase64Image();
        console.warn(error);
      });
    }
  }, {
    key: "fileChanged",
    value: function fileChanged() {
      var file = this.fileHolder.files[0];
      this.readAndUploadFile(file);
    }
  }, {
    key: "insertBase64Image",
    value: function insertBase64Image(url) {
      var range = this.range;

      this.quill.insertEmbed(range.index, _blots_image_js__WEBPACK_IMPORTED_MODULE_0__["default"].blotName, "" + url, "user");
    }
  }, {
    key: "insertToEditor",
    value: function insertToEditor(url) {
      var range = this.range;
      // Delete the placeholder image

      this.quill.deleteText(range.index, 3, "user");
      // Insert the server saved image
      this.quill.insertEmbed(range.index, "image", "" + url, "user");

      range.index++;
      this.quill.setSelection(range, "user");
    }
  }, {
    key: "removeBase64Image",
    value: function removeBase64Image() {
      var range = this.range;

      this.quill.deleteText(range.index, 3, "user");
    }
  }]);

  return ImageUploader;
}();

window.ImageUploader = ImageUploader;
/* harmony default export */ __webpack_exports__["default"] = (ImageUploader);

/***/ }),
/* 1 */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var quill__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(2);
/* harmony import */ var quill__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(quill__WEBPACK_IMPORTED_MODULE_0__);
var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _get = function get(object, property, receiver) { if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { return get(parent, property, receiver); } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } };

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }



var InlineBlot = quill__WEBPACK_IMPORTED_MODULE_0___default.a.import('blots/block');

var LoadingImage = function (_InlineBlot) {
  _inherits(LoadingImage, _InlineBlot);

  function LoadingImage() {
    _classCallCheck(this, LoadingImage);

    return _possibleConstructorReturn(this, (LoadingImage.__proto__ || Object.getPrototypeOf(LoadingImage)).apply(this, arguments));
  }

  _createClass(LoadingImage, [{
    key: 'deleteAt',
    value: function deleteAt(index, length) {
      _get(LoadingImage.prototype.__proto__ || Object.getPrototypeOf(LoadingImage.prototype), 'deleteAt', this).call(this, index, length);
      this.cache = {};
    }
  }], [{
    key: 'create',
    value: function create(src) {
      var node = _get(LoadingImage.__proto__ || Object.getPrototypeOf(LoadingImage), 'create', this).call(this, src);
      if (src === true) return node;

      var image = document.createElement('img');
      image.setAttribute('src', src);
      node.appendChild(image);
      return node;
    }
  }, {
    key: 'value',
    value: function value(domNode) {
      var _domNode$dataset = domNode.dataset,
          src = _domNode$dataset.src,
          custom = _domNode$dataset.custom;

      return { src: src, custom: custom };
    }
  }]);

  return LoadingImage;
}(InlineBlot);

LoadingImage.blotName = 'imageBlot';
LoadingImage.className = 'quill-image-uploading';
LoadingImage.tagName = 'span';
quill__WEBPACK_IMPORTED_MODULE_0___default.a.register({ 'formats/imageBlot': LoadingImage });

/* harmony default export */ __webpack_exports__["default"] = (LoadingImage);

/***/ }),
/* 2 */
/***/ (function(module, exports) {

module.exports = Quill;

/***/ }),
/* 3 */
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ })
/******/ ]);