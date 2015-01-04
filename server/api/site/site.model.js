'use strict';

var mongoose = require('mongoose-bird')();
var Schema = mongoose.Schema;
var slug = require('slug');

function isSlug(value){
  return /^[a-z0-9]+(?:-[A-Za-z0-9]+)*$/.test(value)
}


var SubSchema = new Schema({
  title:String
});

SubSchema.virtual('slug').get(function(){
  return slug(this.title);  
});

var MenuSchema = new Schema({
  title:String,
  sub:[SubSchema]
});

MenuSchema.virtual('slug').get(function(){
  return slug(this.title).toLowerCase();
});

var SiteSchema = new Schema({
  siteName: String,
  domainName:{
    type:String,
    unique:true,
    validate:[isSlug,'not valid slug']
  },
  menuItems:[MenuSchema],
  active: Boolean
});

SiteSchema.set('toJSON', {
   virtuals: true
});

module.exports = mongoose.model('Site', SiteSchema);
