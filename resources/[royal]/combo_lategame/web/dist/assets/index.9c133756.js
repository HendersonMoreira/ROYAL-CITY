(function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const o of document.querySelectorAll('link[rel="modulepreload"]'))r(o);new MutationObserver(o=>{for(const i of o)if(i.type==="childList")for(const s of i.addedNodes)s.tagName==="LINK"&&s.rel==="modulepreload"&&r(s)}).observe(document,{childList:!0,subtree:!0});function n(o){const i={};return o.integrity&&(i.integrity=o.integrity),o.referrerpolicy&&(i.referrerPolicy=o.referrerpolicy),o.crossorigin==="use-credentials"?i.credentials="include":o.crossorigin==="anonymous"?i.credentials="omit":i.credentials="same-origin",i}function r(o){if(o.ep)return;o.ep=!0;const i=n(o);fetch(o.href,i)}})();function Em(e){return e&&e.__esModule&&Object.prototype.hasOwnProperty.call(e,"default")?e.default:e}var Fl={},of={exports:{}},vt={},v={exports:{}},le={};/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var Vo=Symbol.for("react.element"),Tm=Symbol.for("react.portal"),bm=Symbol.for("react.fragment"),$m=Symbol.for("react.strict_mode"),Pm=Symbol.for("react.profiler"),Am=Symbol.for("react.provider"),Rm=Symbol.for("react.context"),Nm=Symbol.for("react.forward_ref"),Fm=Symbol.for("react.suspense"),Lm=Symbol.for("react.memo"),Mm=Symbol.for("react.lazy"),xc=Symbol.iterator;function Om(e){return e===null||typeof e!="object"?null:(e=xc&&e[xc]||e["@@iterator"],typeof e=="function"?e:null)}var sf={isMounted:function(){return!1},enqueueForceUpdate:function(){},enqueueReplaceState:function(){},enqueueSetState:function(){}},lf=Object.assign,af={};function Hr(e,t,n){this.props=e,this.context=t,this.refs=af,this.updater=n||sf}Hr.prototype.isReactComponent={};Hr.prototype.setState=function(e,t){if(typeof e!="object"&&typeof e!="function"&&e!=null)throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");this.updater.enqueueSetState(this,e,t,"setState")};Hr.prototype.forceUpdate=function(e){this.updater.enqueueForceUpdate(this,e,"forceUpdate")};function uf(){}uf.prototype=Hr.prototype;function su(e,t,n){this.props=e,this.context=t,this.refs=af,this.updater=n||sf}var lu=su.prototype=new uf;lu.constructor=su;lf(lu,Hr.prototype);lu.isPureReactComponent=!0;var kc=Array.isArray,cf=Object.prototype.hasOwnProperty,au={current:null},df={key:!0,ref:!0,__self:!0,__source:!0};function ff(e,t,n){var r,o={},i=null,s=null;if(t!=null)for(r in t.ref!==void 0&&(s=t.ref),t.key!==void 0&&(i=""+t.key),t)cf.call(t,r)&&!df.hasOwnProperty(r)&&(o[r]=t[r]);var l=arguments.length-2;if(l===1)o.children=n;else if(1<l){for(var a=Array(l),u=0;u<l;u++)a[u]=arguments[u+2];o.children=a}if(e&&e.defaultProps)for(r in l=e.defaultProps,l)o[r]===void 0&&(o[r]=l[r]);return{$$typeof:Vo,type:e,key:i,ref:s,props:o,_owner:au.current}}function zm(e,t){return{$$typeof:Vo,type:e.type,key:t,ref:e.ref,props:e.props,_owner:e._owner}}function uu(e){return typeof e=="object"&&e!==null&&e.$$typeof===Vo}function Im(e){var t={"=":"=0",":":"=2"};return"$"+e.replace(/[=:]/g,function(n){return t[n]})}var Sc=/\/+/g;function Xs(e,t){return typeof e=="object"&&e!==null&&e.key!=null?Im(""+e.key):t.toString(36)}function gi(e,t,n,r,o){var i=typeof e;(i==="undefined"||i==="boolean")&&(e=null);var s=!1;if(e===null)s=!0;else switch(i){case"string":case"number":s=!0;break;case"object":switch(e.$$typeof){case Vo:case Tm:s=!0}}if(s)return s=e,o=o(s),e=r===""?"."+Xs(s,0):r,kc(o)?(n="",e!=null&&(n=e.replace(Sc,"$&/")+"/"),gi(o,t,n,"",function(u){return u})):o!=null&&(uu(o)&&(o=zm(o,n+(!o.key||s&&s.key===o.key?"":(""+o.key).replace(Sc,"$&/")+"/")+e)),t.push(o)),1;if(s=0,r=r===""?".":r+":",kc(e))for(var l=0;l<e.length;l++){i=e[l];var a=r+Xs(i,l);s+=gi(i,t,n,a,o)}else if(a=Om(e),typeof a=="function")for(e=a.call(e),l=0;!(i=e.next()).done;)i=i.value,a=r+Xs(i,l++),s+=gi(i,t,n,a,o);else if(i==="object")throw t=String(e),Error("Objects are not valid as a React child (found: "+(t==="[object Object]"?"object with keys {"+Object.keys(e).join(", ")+"}":t)+"). If you meant to render a collection of children, use an array instead.");return s}function Ko(e,t,n){if(e==null)return e;var r=[],o=0;return gi(e,r,"","",function(i){return t.call(n,i,o++)}),r}function Dm(e){if(e._status===-1){var t=e._result;t=t(),t.then(function(n){(e._status===0||e._status===-1)&&(e._status=1,e._result=n)},function(n){(e._status===0||e._status===-1)&&(e._status=2,e._result=n)}),e._status===-1&&(e._status=0,e._result=t)}if(e._status===1)return e._result.default;throw e._result}var rt={current:null},yi={transition:null},jm={ReactCurrentDispatcher:rt,ReactCurrentBatchConfig:yi,ReactCurrentOwner:au};le.Children={map:Ko,forEach:function(e,t,n){Ko(e,function(){t.apply(this,arguments)},n)},count:function(e){var t=0;return Ko(e,function(){t++}),t},toArray:function(e){return Ko(e,function(t){return t})||[]},only:function(e){if(!uu(e))throw Error("React.Children.only expected to receive a single React element child.");return e}};le.Component=Hr;le.Fragment=bm;le.Profiler=Pm;le.PureComponent=su;le.StrictMode=$m;le.Suspense=Fm;le.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=jm;le.cloneElement=function(e,t,n){if(e==null)throw Error("React.cloneElement(...): The argument must be a React element, but you passed "+e+".");var r=lf({},e.props),o=e.key,i=e.ref,s=e._owner;if(t!=null){if(t.ref!==void 0&&(i=t.ref,s=au.current),t.key!==void 0&&(o=""+t.key),e.type&&e.type.defaultProps)var l=e.type.defaultProps;for(a in t)cf.call(t,a)&&!df.hasOwnProperty(a)&&(r[a]=t[a]===void 0&&l!==void 0?l[a]:t[a])}var a=arguments.length-2;if(a===1)r.children=n;else if(1<a){l=Array(a);for(var u=0;u<a;u++)l[u]=arguments[u+2];r.children=l}return{$$typeof:Vo,type:e.type,key:o,ref:i,props:r,_owner:s}};le.createContext=function(e){return e={$$typeof:Rm,_currentValue:e,_currentValue2:e,_threadCount:0,Provider:null,Consumer:null,_defaultValue:null,_globalName:null},e.Provider={$$typeof:Am,_context:e},e.Consumer=e};le.createElement=ff;le.createFactory=function(e){var t=ff.bind(null,e);return t.type=e,t};le.createRef=function(){return{current:null}};le.forwardRef=function(e){return{$$typeof:Nm,render:e}};le.isValidElement=uu;le.lazy=function(e){return{$$typeof:Mm,_payload:{_status:-1,_result:e},_init:Dm}};le.memo=function(e,t){return{$$typeof:Lm,type:e,compare:t===void 0?null:t}};le.startTransition=function(e){var t=yi.transition;yi.transition={};try{e()}finally{yi.transition=t}};le.unstable_act=function(){throw Error("act(...) is not supported in production builds of React.")};le.useCallback=function(e,t){return rt.current.useCallback(e,t)};le.useContext=function(e){return rt.current.useContext(e)};le.useDebugValue=function(){};le.useDeferredValue=function(e){return rt.current.useDeferredValue(e)};le.useEffect=function(e,t){return rt.current.useEffect(e,t)};le.useId=function(){return rt.current.useId()};le.useImperativeHandle=function(e,t,n){return rt.current.useImperativeHandle(e,t,n)};le.useInsertionEffect=function(e,t){return rt.current.useInsertionEffect(e,t)};le.useLayoutEffect=function(e,t){return rt.current.useLayoutEffect(e,t)};le.useMemo=function(e,t){return rt.current.useMemo(e,t)};le.useReducer=function(e,t,n){return rt.current.useReducer(e,t,n)};le.useRef=function(e){return rt.current.useRef(e)};le.useState=function(e){return rt.current.useState(e)};le.useSyncExternalStore=function(e,t,n){return rt.current.useSyncExternalStore(e,t,n)};le.useTransition=function(){return rt.current.useTransition()};le.version="18.2.0";(function(e){e.exports=le})(v);const he=Em(v.exports);var pf={exports:{}},hf={};/**
 * @license React
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */(function(e){function t(F,G){var q=F.length;F.push(G);e:for(;0<q;){var me=q-1>>>1,O=F[me];if(0<o(O,G))F[me]=G,F[q]=O,q=me;else break e}}function n(F){return F.length===0?null:F[0]}function r(F){if(F.length===0)return null;var G=F[0],q=F.pop();if(q!==G){F[0]=q;e:for(var me=0,O=F.length,V=O>>>1;me<V;){var U=2*(me+1)-1,X=F[U],w=U+1,ie=F[w];if(0>o(X,q))w<O&&0>o(ie,X)?(F[me]=ie,F[w]=q,me=w):(F[me]=X,F[U]=q,me=U);else if(w<O&&0>o(ie,q))F[me]=ie,F[w]=q,me=w;else break e}}return G}function o(F,G){var q=F.sortIndex-G.sortIndex;return q!==0?q:F.id-G.id}if(typeof performance=="object"&&typeof performance.now=="function"){var i=performance;e.unstable_now=function(){return i.now()}}else{var s=Date,l=s.now();e.unstable_now=function(){return s.now()-l}}var a=[],u=[],c=1,d=null,p=3,C=!1,S=!1,E=!1,M=typeof setTimeout=="function"?setTimeout:null,h=typeof clearTimeout=="function"?clearTimeout:null,f=typeof setImmediate<"u"?setImmediate:null;typeof navigator<"u"&&navigator.scheduling!==void 0&&navigator.scheduling.isInputPending!==void 0&&navigator.scheduling.isInputPending.bind(navigator.scheduling);function g(F){for(var G=n(u);G!==null;){if(G.callback===null)r(u);else if(G.startTime<=F)r(u),G.sortIndex=G.expirationTime,t(a,G);else break;G=n(u)}}function x(F){if(E=!1,g(F),!S)if(n(a)!==null)S=!0,He($);else{var G=n(u);G!==null&&je(x,G.startTime-F)}}function $(F,G){S=!1,E&&(E=!1,h(I),I=-1),C=!0;var q=p;try{for(g(G),d=n(a);d!==null&&(!(d.expirationTime>G)||F&&!Z());){var me=d.callback;if(typeof me=="function"){d.callback=null,p=d.priorityLevel;var O=me(d.expirationTime<=G);G=e.unstable_now(),typeof O=="function"?d.callback=O:d===n(a)&&r(a),g(G)}else r(a);d=n(a)}if(d!==null)var V=!0;else{var U=n(u);U!==null&&je(x,U.startTime-G),V=!1}return V}finally{d=null,p=q,C=!1}}var z=!1,D=null,I=-1,te=5,K=-1;function Z(){return!(e.unstable_now()-K<te)}function Y(){if(D!==null){var F=e.unstable_now();K=F;var G=!0;try{G=D(!0,F)}finally{G?ae():(z=!1,D=null)}}else z=!1}var ae;if(typeof f=="function")ae=function(){f(Y)};else if(typeof MessageChannel<"u"){var ve=new MessageChannel,we=ve.port2;ve.port1.onmessage=Y,ae=function(){we.postMessage(null)}}else ae=function(){M(Y,0)};function He(F){D=F,z||(z=!0,ae())}function je(F,G){I=M(function(){F(e.unstable_now())},G)}e.unstable_IdlePriority=5,e.unstable_ImmediatePriority=1,e.unstable_LowPriority=4,e.unstable_NormalPriority=3,e.unstable_Profiling=null,e.unstable_UserBlockingPriority=2,e.unstable_cancelCallback=function(F){F.callback=null},e.unstable_continueExecution=function(){S||C||(S=!0,He($))},e.unstable_forceFrameRate=function(F){0>F||125<F?console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported"):te=0<F?Math.floor(1e3/F):5},e.unstable_getCurrentPriorityLevel=function(){return p},e.unstable_getFirstCallbackNode=function(){return n(a)},e.unstable_next=function(F){switch(p){case 1:case 2:case 3:var G=3;break;default:G=p}var q=p;p=G;try{return F()}finally{p=q}},e.unstable_pauseExecution=function(){},e.unstable_requestPaint=function(){},e.unstable_runWithPriority=function(F,G){switch(F){case 1:case 2:case 3:case 4:case 5:break;default:F=3}var q=p;p=F;try{return G()}finally{p=q}},e.unstable_scheduleCallback=function(F,G,q){var me=e.unstable_now();switch(typeof q=="object"&&q!==null?(q=q.delay,q=typeof q=="number"&&0<q?me+q:me):q=me,F){case 1:var O=-1;break;case 2:O=250;break;case 5:O=1073741823;break;case 4:O=1e4;break;default:O=5e3}return O=q+O,F={id:c++,callback:G,priorityLevel:F,startTime:q,expirationTime:O,sortIndex:-1},q>me?(F.sortIndex=q,t(u,F),n(a)===null&&F===n(u)&&(E?(h(I),I=-1):E=!0,je(x,q-me))):(F.sortIndex=O,t(a,F),S||C||(S=!0,He($))),F},e.unstable_shouldYield=Z,e.unstable_wrapCallback=function(F){var G=p;return function(){var q=p;p=G;try{return F.apply(this,arguments)}finally{p=q}}}})(hf);(function(e){e.exports=hf})(pf);/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var mf=v.exports,yt=pf.exports;function A(e){for(var t="https://reactjs.org/docs/error-decoder.html?invariant="+e,n=1;n<arguments.length;n++)t+="&args[]="+encodeURIComponent(arguments[n]);return"Minified React error #"+e+"; visit "+t+" for the full message or use the non-minified dev environment for full errors and additional helpful warnings."}var gf=new Set,ko={};function nr(e,t){Nr(e,t),Nr(e+"Capture",t)}function Nr(e,t){for(ko[e]=t,e=0;e<t.length;e++)gf.add(t[e])}var rn=!(typeof window>"u"||typeof window.document>"u"||typeof window.document.createElement>"u"),Ll=Object.prototype.hasOwnProperty,Vm=/^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,_c={},Cc={};function Um(e){return Ll.call(Cc,e)?!0:Ll.call(_c,e)?!1:Vm.test(e)?Cc[e]=!0:(_c[e]=!0,!1)}function Bm(e,t,n,r){if(n!==null&&n.type===0)return!1;switch(typeof t){case"function":case"symbol":return!0;case"boolean":return r?!1:n!==null?!n.acceptsBooleans:(e=e.toLowerCase().slice(0,5),e!=="data-"&&e!=="aria-");default:return!1}}function Wm(e,t,n,r){if(t===null||typeof t>"u"||Bm(e,t,n,r))return!0;if(r)return!1;if(n!==null)switch(n.type){case 3:return!t;case 4:return t===!1;case 5:return isNaN(t);case 6:return isNaN(t)||1>t}return!1}function ot(e,t,n,r,o,i,s){this.acceptsBooleans=t===2||t===3||t===4,this.attributeName=r,this.attributeNamespace=o,this.mustUseProperty=n,this.propertyName=e,this.type=t,this.sanitizeURL=i,this.removeEmptyString=s}var Ye={};"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function(e){Ye[e]=new ot(e,0,!1,e,null,!1,!1)});[["acceptCharset","accept-charset"],["className","class"],["htmlFor","for"],["httpEquiv","http-equiv"]].forEach(function(e){var t=e[0];Ye[t]=new ot(t,1,!1,e[1],null,!1,!1)});["contentEditable","draggable","spellCheck","value"].forEach(function(e){Ye[e]=new ot(e,2,!1,e.toLowerCase(),null,!1,!1)});["autoReverse","externalResourcesRequired","focusable","preserveAlpha"].forEach(function(e){Ye[e]=new ot(e,2,!1,e,null,!1,!1)});"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function(e){Ye[e]=new ot(e,3,!1,e.toLowerCase(),null,!1,!1)});["checked","multiple","muted","selected"].forEach(function(e){Ye[e]=new ot(e,3,!0,e,null,!1,!1)});["capture","download"].forEach(function(e){Ye[e]=new ot(e,4,!1,e,null,!1,!1)});["cols","rows","size","span"].forEach(function(e){Ye[e]=new ot(e,6,!1,e,null,!1,!1)});["rowSpan","start"].forEach(function(e){Ye[e]=new ot(e,5,!1,e.toLowerCase(),null,!1,!1)});var cu=/[\-:]([a-z])/g;function du(e){return e[1].toUpperCase()}"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function(e){var t=e.replace(cu,du);Ye[t]=new ot(t,1,!1,e,null,!1,!1)});"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function(e){var t=e.replace(cu,du);Ye[t]=new ot(t,1,!1,e,"http://www.w3.org/1999/xlink",!1,!1)});["xml:base","xml:lang","xml:space"].forEach(function(e){var t=e.replace(cu,du);Ye[t]=new ot(t,1,!1,e,"http://www.w3.org/XML/1998/namespace",!1,!1)});["tabIndex","crossOrigin"].forEach(function(e){Ye[e]=new ot(e,1,!1,e.toLowerCase(),null,!1,!1)});Ye.xlinkHref=new ot("xlinkHref",1,!1,"xlink:href","http://www.w3.org/1999/xlink",!0,!1);["src","href","action","formAction"].forEach(function(e){Ye[e]=new ot(e,1,!1,e.toLowerCase(),null,!0,!0)});function fu(e,t,n,r){var o=Ye.hasOwnProperty(t)?Ye[t]:null;(o!==null?o.type!==0:r||!(2<t.length)||t[0]!=="o"&&t[0]!=="O"||t[1]!=="n"&&t[1]!=="N")&&(Wm(t,n,o,r)&&(n=null),r||o===null?Um(t)&&(n===null?e.removeAttribute(t):e.setAttribute(t,""+n)):o.mustUseProperty?e[o.propertyName]=n===null?o.type===3?!1:"":n:(t=o.attributeName,r=o.attributeNamespace,n===null?e.removeAttribute(t):(o=o.type,n=o===3||o===4&&n===!0?"":""+n,r?e.setAttributeNS(r,t,n):e.setAttribute(t,n))))}var cn=mf.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,Xo=Symbol.for("react.element"),ar=Symbol.for("react.portal"),ur=Symbol.for("react.fragment"),pu=Symbol.for("react.strict_mode"),Ml=Symbol.for("react.profiler"),yf=Symbol.for("react.provider"),vf=Symbol.for("react.context"),hu=Symbol.for("react.forward_ref"),Ol=Symbol.for("react.suspense"),zl=Symbol.for("react.suspense_list"),mu=Symbol.for("react.memo"),hn=Symbol.for("react.lazy"),wf=Symbol.for("react.offscreen"),Ec=Symbol.iterator;function Gr(e){return e===null||typeof e!="object"?null:(e=Ec&&e[Ec]||e["@@iterator"],typeof e=="function"?e:null)}var Ae=Object.assign,qs;function oo(e){if(qs===void 0)try{throw Error()}catch(n){var t=n.stack.trim().match(/\n( *(at )?)/);qs=t&&t[1]||""}return`
`+qs+e}var Js=!1;function el(e,t){if(!e||Js)return"";Js=!0;var n=Error.prepareStackTrace;Error.prepareStackTrace=void 0;try{if(t)if(t=function(){throw Error()},Object.defineProperty(t.prototype,"props",{set:function(){throw Error()}}),typeof Reflect=="object"&&Reflect.construct){try{Reflect.construct(t,[])}catch(u){var r=u}Reflect.construct(e,[],t)}else{try{t.call()}catch(u){r=u}e.call(t.prototype)}else{try{throw Error()}catch(u){r=u}e()}}catch(u){if(u&&r&&typeof u.stack=="string"){for(var o=u.stack.split(`
`),i=r.stack.split(`
`),s=o.length-1,l=i.length-1;1<=s&&0<=l&&o[s]!==i[l];)l--;for(;1<=s&&0<=l;s--,l--)if(o[s]!==i[l]){if(s!==1||l!==1)do if(s--,l--,0>l||o[s]!==i[l]){var a=`
`+o[s].replace(" at new "," at ");return e.displayName&&a.includes("<anonymous>")&&(a=a.replace("<anonymous>",e.displayName)),a}while(1<=s&&0<=l);break}}}finally{Js=!1,Error.prepareStackTrace=n}return(e=e?e.displayName||e.name:"")?oo(e):""}function Hm(e){switch(e.tag){case 5:return oo(e.type);case 16:return oo("Lazy");case 13:return oo("Suspense");case 19:return oo("SuspenseList");case 0:case 2:case 15:return e=el(e.type,!1),e;case 11:return e=el(e.type.render,!1),e;case 1:return e=el(e.type,!0),e;default:return""}}function Il(e){if(e==null)return null;if(typeof e=="function")return e.displayName||e.name||null;if(typeof e=="string")return e;switch(e){case ur:return"Fragment";case ar:return"Portal";case Ml:return"Profiler";case pu:return"StrictMode";case Ol:return"Suspense";case zl:return"SuspenseList"}if(typeof e=="object")switch(e.$$typeof){case vf:return(e.displayName||"Context")+".Consumer";case yf:return(e._context.displayName||"Context")+".Provider";case hu:var t=e.render;return e=e.displayName,e||(e=t.displayName||t.name||"",e=e!==""?"ForwardRef("+e+")":"ForwardRef"),e;case mu:return t=e.displayName||null,t!==null?t:Il(e.type)||"Memo";case hn:t=e._payload,e=e._init;try{return Il(e(t))}catch{}}return null}function Zm(e){var t=e.type;switch(e.tag){case 24:return"Cache";case 9:return(t.displayName||"Context")+".Consumer";case 10:return(t._context.displayName||"Context")+".Provider";case 18:return"DehydratedFragment";case 11:return e=t.render,e=e.displayName||e.name||"",t.displayName||(e!==""?"ForwardRef("+e+")":"ForwardRef");case 7:return"Fragment";case 5:return t;case 4:return"Portal";case 3:return"Root";case 6:return"Text";case 16:return Il(t);case 8:return t===pu?"StrictMode":"Mode";case 22:return"Offscreen";case 12:return"Profiler";case 21:return"Scope";case 13:return"Suspense";case 19:return"SuspenseList";case 25:return"TracingMarker";case 1:case 0:case 17:case 2:case 14:case 15:if(typeof t=="function")return t.displayName||t.name||null;if(typeof t=="string")return t}return null}function An(e){switch(typeof e){case"boolean":case"number":case"string":case"undefined":return e;case"object":return e;default:return""}}function xf(e){var t=e.type;return(e=e.nodeName)&&e.toLowerCase()==="input"&&(t==="checkbox"||t==="radio")}function Qm(e){var t=xf(e)?"checked":"value",n=Object.getOwnPropertyDescriptor(e.constructor.prototype,t),r=""+e[t];if(!e.hasOwnProperty(t)&&typeof n<"u"&&typeof n.get=="function"&&typeof n.set=="function"){var o=n.get,i=n.set;return Object.defineProperty(e,t,{configurable:!0,get:function(){return o.call(this)},set:function(s){r=""+s,i.call(this,s)}}),Object.defineProperty(e,t,{enumerable:n.enumerable}),{getValue:function(){return r},setValue:function(s){r=""+s},stopTracking:function(){e._valueTracker=null,delete e[t]}}}}function qo(e){e._valueTracker||(e._valueTracker=Qm(e))}function kf(e){if(!e)return!1;var t=e._valueTracker;if(!t)return!0;var n=t.getValue(),r="";return e&&(r=xf(e)?e.checked?"true":"false":e.value),e=r,e!==n?(t.setValue(e),!0):!1}function Ri(e){if(e=e||(typeof document<"u"?document:void 0),typeof e>"u")return null;try{return e.activeElement||e.body}catch{return e.body}}function Dl(e,t){var n=t.checked;return Ae({},t,{defaultChecked:void 0,defaultValue:void 0,value:void 0,checked:n!=null?n:e._wrapperState.initialChecked})}function Tc(e,t){var n=t.defaultValue==null?"":t.defaultValue,r=t.checked!=null?t.checked:t.defaultChecked;n=An(t.value!=null?t.value:n),e._wrapperState={initialChecked:r,initialValue:n,controlled:t.type==="checkbox"||t.type==="radio"?t.checked!=null:t.value!=null}}function Sf(e,t){t=t.checked,t!=null&&fu(e,"checked",t,!1)}function jl(e,t){Sf(e,t);var n=An(t.value),r=t.type;if(n!=null)r==="number"?(n===0&&e.value===""||e.value!=n)&&(e.value=""+n):e.value!==""+n&&(e.value=""+n);else if(r==="submit"||r==="reset"){e.removeAttribute("value");return}t.hasOwnProperty("value")?Vl(e,t.type,n):t.hasOwnProperty("defaultValue")&&Vl(e,t.type,An(t.defaultValue)),t.checked==null&&t.defaultChecked!=null&&(e.defaultChecked=!!t.defaultChecked)}function bc(e,t,n){if(t.hasOwnProperty("value")||t.hasOwnProperty("defaultValue")){var r=t.type;if(!(r!=="submit"&&r!=="reset"||t.value!==void 0&&t.value!==null))return;t=""+e._wrapperState.initialValue,n||t===e.value||(e.value=t),e.defaultValue=t}n=e.name,n!==""&&(e.name=""),e.defaultChecked=!!e._wrapperState.initialChecked,n!==""&&(e.name=n)}function Vl(e,t,n){(t!=="number"||Ri(e.ownerDocument)!==e)&&(n==null?e.defaultValue=""+e._wrapperState.initialValue:e.defaultValue!==""+n&&(e.defaultValue=""+n))}var io=Array.isArray;function Cr(e,t,n,r){if(e=e.options,t){t={};for(var o=0;o<n.length;o++)t["$"+n[o]]=!0;for(n=0;n<e.length;n++)o=t.hasOwnProperty("$"+e[n].value),e[n].selected!==o&&(e[n].selected=o),o&&r&&(e[n].defaultSelected=!0)}else{for(n=""+An(n),t=null,o=0;o<e.length;o++){if(e[o].value===n){e[o].selected=!0,r&&(e[o].defaultSelected=!0);return}t!==null||e[o].disabled||(t=e[o])}t!==null&&(t.selected=!0)}}function Ul(e,t){if(t.dangerouslySetInnerHTML!=null)throw Error(A(91));return Ae({},t,{value:void 0,defaultValue:void 0,children:""+e._wrapperState.initialValue})}function $c(e,t){var n=t.value;if(n==null){if(n=t.children,t=t.defaultValue,n!=null){if(t!=null)throw Error(A(92));if(io(n)){if(1<n.length)throw Error(A(93));n=n[0]}t=n}t==null&&(t=""),n=t}e._wrapperState={initialValue:An(n)}}function _f(e,t){var n=An(t.value),r=An(t.defaultValue);n!=null&&(n=""+n,n!==e.value&&(e.value=n),t.defaultValue==null&&e.defaultValue!==n&&(e.defaultValue=n)),r!=null&&(e.defaultValue=""+r)}function Pc(e){var t=e.textContent;t===e._wrapperState.initialValue&&t!==""&&t!==null&&(e.value=t)}function Cf(e){switch(e){case"svg":return"http://www.w3.org/2000/svg";case"math":return"http://www.w3.org/1998/Math/MathML";default:return"http://www.w3.org/1999/xhtml"}}function Bl(e,t){return e==null||e==="http://www.w3.org/1999/xhtml"?Cf(t):e==="http://www.w3.org/2000/svg"&&t==="foreignObject"?"http://www.w3.org/1999/xhtml":e}var Jo,Ef=function(e){return typeof MSApp<"u"&&MSApp.execUnsafeLocalFunction?function(t,n,r,o){MSApp.execUnsafeLocalFunction(function(){return e(t,n,r,o)})}:e}(function(e,t){if(e.namespaceURI!=="http://www.w3.org/2000/svg"||"innerHTML"in e)e.innerHTML=t;else{for(Jo=Jo||document.createElement("div"),Jo.innerHTML="<svg>"+t.valueOf().toString()+"</svg>",t=Jo.firstChild;e.firstChild;)e.removeChild(e.firstChild);for(;t.firstChild;)e.appendChild(t.firstChild)}});function So(e,t){if(t){var n=e.firstChild;if(n&&n===e.lastChild&&n.nodeType===3){n.nodeValue=t;return}}e.textContent=t}var uo={animationIterationCount:!0,aspectRatio:!0,borderImageOutset:!0,borderImageSlice:!0,borderImageWidth:!0,boxFlex:!0,boxFlexGroup:!0,boxOrdinalGroup:!0,columnCount:!0,columns:!0,flex:!0,flexGrow:!0,flexPositive:!0,flexShrink:!0,flexNegative:!0,flexOrder:!0,gridArea:!0,gridRow:!0,gridRowEnd:!0,gridRowSpan:!0,gridRowStart:!0,gridColumn:!0,gridColumnEnd:!0,gridColumnSpan:!0,gridColumnStart:!0,fontWeight:!0,lineClamp:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,tabSize:!0,widows:!0,zIndex:!0,zoom:!0,fillOpacity:!0,floodOpacity:!0,stopOpacity:!0,strokeDasharray:!0,strokeDashoffset:!0,strokeMiterlimit:!0,strokeOpacity:!0,strokeWidth:!0},Ym=["Webkit","ms","Moz","O"];Object.keys(uo).forEach(function(e){Ym.forEach(function(t){t=t+e.charAt(0).toUpperCase()+e.substring(1),uo[t]=uo[e]})});function Tf(e,t,n){return t==null||typeof t=="boolean"||t===""?"":n||typeof t!="number"||t===0||uo.hasOwnProperty(e)&&uo[e]?(""+t).trim():t+"px"}function bf(e,t){e=e.style;for(var n in t)if(t.hasOwnProperty(n)){var r=n.indexOf("--")===0,o=Tf(n,t[n],r);n==="float"&&(n="cssFloat"),r?e.setProperty(n,o):e[n]=o}}var Gm=Ae({menuitem:!0},{area:!0,base:!0,br:!0,col:!0,embed:!0,hr:!0,img:!0,input:!0,keygen:!0,link:!0,meta:!0,param:!0,source:!0,track:!0,wbr:!0});function Wl(e,t){if(t){if(Gm[e]&&(t.children!=null||t.dangerouslySetInnerHTML!=null))throw Error(A(137,e));if(t.dangerouslySetInnerHTML!=null){if(t.children!=null)throw Error(A(60));if(typeof t.dangerouslySetInnerHTML!="object"||!("__html"in t.dangerouslySetInnerHTML))throw Error(A(61))}if(t.style!=null&&typeof t.style!="object")throw Error(A(62))}}function Hl(e,t){if(e.indexOf("-")===-1)return typeof t.is=="string";switch(e){case"annotation-xml":case"color-profile":case"font-face":case"font-face-src":case"font-face-uri":case"font-face-format":case"font-face-name":case"missing-glyph":return!1;default:return!0}}var Zl=null;function gu(e){return e=e.target||e.srcElement||window,e.correspondingUseElement&&(e=e.correspondingUseElement),e.nodeType===3?e.parentNode:e}var Ql=null,Er=null,Tr=null;function Ac(e){if(e=Wo(e)){if(typeof Ql!="function")throw Error(A(280));var t=e.stateNode;t&&(t=ks(t),Ql(e.stateNode,e.type,t))}}function $f(e){Er?Tr?Tr.push(e):Tr=[e]:Er=e}function Pf(){if(Er){var e=Er,t=Tr;if(Tr=Er=null,Ac(e),t)for(e=0;e<t.length;e++)Ac(t[e])}}function Af(e,t){return e(t)}function Rf(){}var tl=!1;function Nf(e,t,n){if(tl)return e(t,n);tl=!0;try{return Af(e,t,n)}finally{tl=!1,(Er!==null||Tr!==null)&&(Rf(),Pf())}}function _o(e,t){var n=e.stateNode;if(n===null)return null;var r=ks(n);if(r===null)return null;n=r[t];e:switch(t){case"onClick":case"onClickCapture":case"onDoubleClick":case"onDoubleClickCapture":case"onMouseDown":case"onMouseDownCapture":case"onMouseMove":case"onMouseMoveCapture":case"onMouseUp":case"onMouseUpCapture":case"onMouseEnter":(r=!r.disabled)||(e=e.type,r=!(e==="button"||e==="input"||e==="select"||e==="textarea")),e=!r;break e;default:e=!1}if(e)return null;if(n&&typeof n!="function")throw Error(A(231,t,typeof n));return n}var Yl=!1;if(rn)try{var Kr={};Object.defineProperty(Kr,"passive",{get:function(){Yl=!0}}),window.addEventListener("test",Kr,Kr),window.removeEventListener("test",Kr,Kr)}catch{Yl=!1}function Km(e,t,n,r,o,i,s,l,a){var u=Array.prototype.slice.call(arguments,3);try{t.apply(n,u)}catch(c){this.onError(c)}}var co=!1,Ni=null,Fi=!1,Gl=null,Xm={onError:function(e){co=!0,Ni=e}};function qm(e,t,n,r,o,i,s,l,a){co=!1,Ni=null,Km.apply(Xm,arguments)}function Jm(e,t,n,r,o,i,s,l,a){if(qm.apply(this,arguments),co){if(co){var u=Ni;co=!1,Ni=null}else throw Error(A(198));Fi||(Fi=!0,Gl=u)}}function rr(e){var t=e,n=e;if(e.alternate)for(;t.return;)t=t.return;else{e=t;do t=e,(t.flags&4098)!==0&&(n=t.return),e=t.return;while(e)}return t.tag===3?n:null}function Ff(e){if(e.tag===13){var t=e.memoizedState;if(t===null&&(e=e.alternate,e!==null&&(t=e.memoizedState)),t!==null)return t.dehydrated}return null}function Rc(e){if(rr(e)!==e)throw Error(A(188))}function e0(e){var t=e.alternate;if(!t){if(t=rr(e),t===null)throw Error(A(188));return t!==e?null:e}for(var n=e,r=t;;){var o=n.return;if(o===null)break;var i=o.alternate;if(i===null){if(r=o.return,r!==null){n=r;continue}break}if(o.child===i.child){for(i=o.child;i;){if(i===n)return Rc(o),e;if(i===r)return Rc(o),t;i=i.sibling}throw Error(A(188))}if(n.return!==r.return)n=o,r=i;else{for(var s=!1,l=o.child;l;){if(l===n){s=!0,n=o,r=i;break}if(l===r){s=!0,r=o,n=i;break}l=l.sibling}if(!s){for(l=i.child;l;){if(l===n){s=!0,n=i,r=o;break}if(l===r){s=!0,r=i,n=o;break}l=l.sibling}if(!s)throw Error(A(189))}}if(n.alternate!==r)throw Error(A(190))}if(n.tag!==3)throw Error(A(188));return n.stateNode.current===n?e:t}function Lf(e){return e=e0(e),e!==null?Mf(e):null}function Mf(e){if(e.tag===5||e.tag===6)return e;for(e=e.child;e!==null;){var t=Mf(e);if(t!==null)return t;e=e.sibling}return null}var Of=yt.unstable_scheduleCallback,Nc=yt.unstable_cancelCallback,t0=yt.unstable_shouldYield,n0=yt.unstable_requestPaint,Me=yt.unstable_now,r0=yt.unstable_getCurrentPriorityLevel,yu=yt.unstable_ImmediatePriority,zf=yt.unstable_UserBlockingPriority,Li=yt.unstable_NormalPriority,o0=yt.unstable_LowPriority,If=yt.unstable_IdlePriority,ys=null,Ht=null;function i0(e){if(Ht&&typeof Ht.onCommitFiberRoot=="function")try{Ht.onCommitFiberRoot(ys,e,void 0,(e.current.flags&128)===128)}catch{}}var Mt=Math.clz32?Math.clz32:a0,s0=Math.log,l0=Math.LN2;function a0(e){return e>>>=0,e===0?32:31-(s0(e)/l0|0)|0}var ei=64,ti=4194304;function so(e){switch(e&-e){case 1:return 1;case 2:return 2;case 4:return 4;case 8:return 8;case 16:return 16;case 32:return 32;case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:return e&4194240;case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:return e&130023424;case 134217728:return 134217728;case 268435456:return 268435456;case 536870912:return 536870912;case 1073741824:return 1073741824;default:return e}}function Mi(e,t){var n=e.pendingLanes;if(n===0)return 0;var r=0,o=e.suspendedLanes,i=e.pingedLanes,s=n&268435455;if(s!==0){var l=s&~o;l!==0?r=so(l):(i&=s,i!==0&&(r=so(i)))}else s=n&~o,s!==0?r=so(s):i!==0&&(r=so(i));if(r===0)return 0;if(t!==0&&t!==r&&(t&o)===0&&(o=r&-r,i=t&-t,o>=i||o===16&&(i&4194240)!==0))return t;if((r&4)!==0&&(r|=n&16),t=e.entangledLanes,t!==0)for(e=e.entanglements,t&=r;0<t;)n=31-Mt(t),o=1<<n,r|=e[n],t&=~o;return r}function u0(e,t){switch(e){case 1:case 2:case 4:return t+250;case 8:case 16:case 32:case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:return t+5e3;case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:return-1;case 134217728:case 268435456:case 536870912:case 1073741824:return-1;default:return-1}}function c0(e,t){for(var n=e.suspendedLanes,r=e.pingedLanes,o=e.expirationTimes,i=e.pendingLanes;0<i;){var s=31-Mt(i),l=1<<s,a=o[s];a===-1?((l&n)===0||(l&r)!==0)&&(o[s]=u0(l,t)):a<=t&&(e.expiredLanes|=l),i&=~l}}function Kl(e){return e=e.pendingLanes&-1073741825,e!==0?e:e&1073741824?1073741824:0}function Df(){var e=ei;return ei<<=1,(ei&4194240)===0&&(ei=64),e}function nl(e){for(var t=[],n=0;31>n;n++)t.push(e);return t}function Uo(e,t,n){e.pendingLanes|=t,t!==536870912&&(e.suspendedLanes=0,e.pingedLanes=0),e=e.eventTimes,t=31-Mt(t),e[t]=n}function d0(e,t){var n=e.pendingLanes&~t;e.pendingLanes=t,e.suspendedLanes=0,e.pingedLanes=0,e.expiredLanes&=t,e.mutableReadLanes&=t,e.entangledLanes&=t,t=e.entanglements;var r=e.eventTimes;for(e=e.expirationTimes;0<n;){var o=31-Mt(n),i=1<<o;t[o]=0,r[o]=-1,e[o]=-1,n&=~i}}function vu(e,t){var n=e.entangledLanes|=t;for(e=e.entanglements;n;){var r=31-Mt(n),o=1<<r;o&t|e[r]&t&&(e[r]|=t),n&=~o}}var ge=0;function jf(e){return e&=-e,1<e?4<e?(e&268435455)!==0?16:536870912:4:1}var Vf,wu,Uf,Bf,Wf,Xl=!1,ni=[],xn=null,kn=null,Sn=null,Co=new Map,Eo=new Map,gn=[],f0="mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");function Fc(e,t){switch(e){case"focusin":case"focusout":xn=null;break;case"dragenter":case"dragleave":kn=null;break;case"mouseover":case"mouseout":Sn=null;break;case"pointerover":case"pointerout":Co.delete(t.pointerId);break;case"gotpointercapture":case"lostpointercapture":Eo.delete(t.pointerId)}}function Xr(e,t,n,r,o,i){return e===null||e.nativeEvent!==i?(e={blockedOn:t,domEventName:n,eventSystemFlags:r,nativeEvent:i,targetContainers:[o]},t!==null&&(t=Wo(t),t!==null&&wu(t)),e):(e.eventSystemFlags|=r,t=e.targetContainers,o!==null&&t.indexOf(o)===-1&&t.push(o),e)}function p0(e,t,n,r,o){switch(t){case"focusin":return xn=Xr(xn,e,t,n,r,o),!0;case"dragenter":return kn=Xr(kn,e,t,n,r,o),!0;case"mouseover":return Sn=Xr(Sn,e,t,n,r,o),!0;case"pointerover":var i=o.pointerId;return Co.set(i,Xr(Co.get(i)||null,e,t,n,r,o)),!0;case"gotpointercapture":return i=o.pointerId,Eo.set(i,Xr(Eo.get(i)||null,e,t,n,r,o)),!0}return!1}function Hf(e){var t=Bn(e.target);if(t!==null){var n=rr(t);if(n!==null){if(t=n.tag,t===13){if(t=Ff(n),t!==null){e.blockedOn=t,Wf(e.priority,function(){Uf(n)});return}}else if(t===3&&n.stateNode.current.memoizedState.isDehydrated){e.blockedOn=n.tag===3?n.stateNode.containerInfo:null;return}}}e.blockedOn=null}function vi(e){if(e.blockedOn!==null)return!1;for(var t=e.targetContainers;0<t.length;){var n=ql(e.domEventName,e.eventSystemFlags,t[0],e.nativeEvent);if(n===null){n=e.nativeEvent;var r=new n.constructor(n.type,n);Zl=r,n.target.dispatchEvent(r),Zl=null}else return t=Wo(n),t!==null&&wu(t),e.blockedOn=n,!1;t.shift()}return!0}function Lc(e,t,n){vi(e)&&n.delete(t)}function h0(){Xl=!1,xn!==null&&vi(xn)&&(xn=null),kn!==null&&vi(kn)&&(kn=null),Sn!==null&&vi(Sn)&&(Sn=null),Co.forEach(Lc),Eo.forEach(Lc)}function qr(e,t){e.blockedOn===t&&(e.blockedOn=null,Xl||(Xl=!0,yt.unstable_scheduleCallback(yt.unstable_NormalPriority,h0)))}function To(e){function t(o){return qr(o,e)}if(0<ni.length){qr(ni[0],e);for(var n=1;n<ni.length;n++){var r=ni[n];r.blockedOn===e&&(r.blockedOn=null)}}for(xn!==null&&qr(xn,e),kn!==null&&qr(kn,e),Sn!==null&&qr(Sn,e),Co.forEach(t),Eo.forEach(t),n=0;n<gn.length;n++)r=gn[n],r.blockedOn===e&&(r.blockedOn=null);for(;0<gn.length&&(n=gn[0],n.blockedOn===null);)Hf(n),n.blockedOn===null&&gn.shift()}var br=cn.ReactCurrentBatchConfig,Oi=!0;function m0(e,t,n,r){var o=ge,i=br.transition;br.transition=null;try{ge=1,xu(e,t,n,r)}finally{ge=o,br.transition=i}}function g0(e,t,n,r){var o=ge,i=br.transition;br.transition=null;try{ge=4,xu(e,t,n,r)}finally{ge=o,br.transition=i}}function xu(e,t,n,r){if(Oi){var o=ql(e,t,n,r);if(o===null)fl(e,t,r,zi,n),Fc(e,r);else if(p0(o,e,t,n,r))r.stopPropagation();else if(Fc(e,r),t&4&&-1<f0.indexOf(e)){for(;o!==null;){var i=Wo(o);if(i!==null&&Vf(i),i=ql(e,t,n,r),i===null&&fl(e,t,r,zi,n),i===o)break;o=i}o!==null&&r.stopPropagation()}else fl(e,t,r,null,n)}}var zi=null;function ql(e,t,n,r){if(zi=null,e=gu(r),e=Bn(e),e!==null)if(t=rr(e),t===null)e=null;else if(n=t.tag,n===13){if(e=Ff(t),e!==null)return e;e=null}else if(n===3){if(t.stateNode.current.memoizedState.isDehydrated)return t.tag===3?t.stateNode.containerInfo:null;e=null}else t!==e&&(e=null);return zi=e,null}function Zf(e){switch(e){case"cancel":case"click":case"close":case"contextmenu":case"copy":case"cut":case"auxclick":case"dblclick":case"dragend":case"dragstart":case"drop":case"focusin":case"focusout":case"input":case"invalid":case"keydown":case"keypress":case"keyup":case"mousedown":case"mouseup":case"paste":case"pause":case"play":case"pointercancel":case"pointerdown":case"pointerup":case"ratechange":case"reset":case"resize":case"seeked":case"submit":case"touchcancel":case"touchend":case"touchstart":case"volumechange":case"change":case"selectionchange":case"textInput":case"compositionstart":case"compositionend":case"compositionupdate":case"beforeblur":case"afterblur":case"beforeinput":case"blur":case"fullscreenchange":case"focus":case"hashchange":case"popstate":case"select":case"selectstart":return 1;case"drag":case"dragenter":case"dragexit":case"dragleave":case"dragover":case"mousemove":case"mouseout":case"mouseover":case"pointermove":case"pointerout":case"pointerover":case"scroll":case"toggle":case"touchmove":case"wheel":case"mouseenter":case"mouseleave":case"pointerenter":case"pointerleave":return 4;case"message":switch(r0()){case yu:return 1;case zf:return 4;case Li:case o0:return 16;case If:return 536870912;default:return 16}default:return 16}}var vn=null,ku=null,wi=null;function Qf(){if(wi)return wi;var e,t=ku,n=t.length,r,o="value"in vn?vn.value:vn.textContent,i=o.length;for(e=0;e<n&&t[e]===o[e];e++);var s=n-e;for(r=1;r<=s&&t[n-r]===o[i-r];r++);return wi=o.slice(e,1<r?1-r:void 0)}function xi(e){var t=e.keyCode;return"charCode"in e?(e=e.charCode,e===0&&t===13&&(e=13)):e=t,e===10&&(e=13),32<=e||e===13?e:0}function ri(){return!0}function Mc(){return!1}function wt(e){function t(n,r,o,i,s){this._reactName=n,this._targetInst=o,this.type=r,this.nativeEvent=i,this.target=s,this.currentTarget=null;for(var l in e)e.hasOwnProperty(l)&&(n=e[l],this[l]=n?n(i):i[l]);return this.isDefaultPrevented=(i.defaultPrevented!=null?i.defaultPrevented:i.returnValue===!1)?ri:Mc,this.isPropagationStopped=Mc,this}return Ae(t.prototype,{preventDefault:function(){this.defaultPrevented=!0;var n=this.nativeEvent;n&&(n.preventDefault?n.preventDefault():typeof n.returnValue!="unknown"&&(n.returnValue=!1),this.isDefaultPrevented=ri)},stopPropagation:function(){var n=this.nativeEvent;n&&(n.stopPropagation?n.stopPropagation():typeof n.cancelBubble!="unknown"&&(n.cancelBubble=!0),this.isPropagationStopped=ri)},persist:function(){},isPersistent:ri}),t}var Zr={eventPhase:0,bubbles:0,cancelable:0,timeStamp:function(e){return e.timeStamp||Date.now()},defaultPrevented:0,isTrusted:0},Su=wt(Zr),Bo=Ae({},Zr,{view:0,detail:0}),y0=wt(Bo),rl,ol,Jr,vs=Ae({},Bo,{screenX:0,screenY:0,clientX:0,clientY:0,pageX:0,pageY:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,getModifierState:_u,button:0,buttons:0,relatedTarget:function(e){return e.relatedTarget===void 0?e.fromElement===e.srcElement?e.toElement:e.fromElement:e.relatedTarget},movementX:function(e){return"movementX"in e?e.movementX:(e!==Jr&&(Jr&&e.type==="mousemove"?(rl=e.screenX-Jr.screenX,ol=e.screenY-Jr.screenY):ol=rl=0,Jr=e),rl)},movementY:function(e){return"movementY"in e?e.movementY:ol}}),Oc=wt(vs),v0=Ae({},vs,{dataTransfer:0}),w0=wt(v0),x0=Ae({},Bo,{relatedTarget:0}),il=wt(x0),k0=Ae({},Zr,{animationName:0,elapsedTime:0,pseudoElement:0}),S0=wt(k0),_0=Ae({},Zr,{clipboardData:function(e){return"clipboardData"in e?e.clipboardData:window.clipboardData}}),C0=wt(_0),E0=Ae({},Zr,{data:0}),zc=wt(E0),T0={Esc:"Escape",Spacebar:" ",Left:"ArrowLeft",Up:"ArrowUp",Right:"ArrowRight",Down:"ArrowDown",Del:"Delete",Win:"OS",Menu:"ContextMenu",Apps:"ContextMenu",Scroll:"ScrollLock",MozPrintableKey:"Unidentified"},b0={8:"Backspace",9:"Tab",12:"Clear",13:"Enter",16:"Shift",17:"Control",18:"Alt",19:"Pause",20:"CapsLock",27:"Escape",32:" ",33:"PageUp",34:"PageDown",35:"End",36:"Home",37:"ArrowLeft",38:"ArrowUp",39:"ArrowRight",40:"ArrowDown",45:"Insert",46:"Delete",112:"F1",113:"F2",114:"F3",115:"F4",116:"F5",117:"F6",118:"F7",119:"F8",120:"F9",121:"F10",122:"F11",123:"F12",144:"NumLock",145:"ScrollLock",224:"Meta"},$0={Alt:"altKey",Control:"ctrlKey",Meta:"metaKey",Shift:"shiftKey"};function P0(e){var t=this.nativeEvent;return t.getModifierState?t.getModifierState(e):(e=$0[e])?!!t[e]:!1}function _u(){return P0}var A0=Ae({},Bo,{key:function(e){if(e.key){var t=T0[e.key]||e.key;if(t!=="Unidentified")return t}return e.type==="keypress"?(e=xi(e),e===13?"Enter":String.fromCharCode(e)):e.type==="keydown"||e.type==="keyup"?b0[e.keyCode]||"Unidentified":""},code:0,location:0,ctrlKey:0,shiftKey:0,altKey:0,metaKey:0,repeat:0,locale:0,getModifierState:_u,charCode:function(e){return e.type==="keypress"?xi(e):0},keyCode:function(e){return e.type==="keydown"||e.type==="keyup"?e.keyCode:0},which:function(e){return e.type==="keypress"?xi(e):e.type==="keydown"||e.type==="keyup"?e.keyCode:0}}),R0=wt(A0),N0=Ae({},vs,{pointerId:0,width:0,height:0,pressure:0,tangentialPressure:0,tiltX:0,tiltY:0,twist:0,pointerType:0,isPrimary:0}),Ic=wt(N0),F0=Ae({},Bo,{touches:0,targetTouches:0,changedTouches:0,altKey:0,metaKey:0,ctrlKey:0,shiftKey:0,getModifierState:_u}),L0=wt(F0),M0=Ae({},Zr,{propertyName:0,elapsedTime:0,pseudoElement:0}),O0=wt(M0),z0=Ae({},vs,{deltaX:function(e){return"deltaX"in e?e.deltaX:"wheelDeltaX"in e?-e.wheelDeltaX:0},deltaY:function(e){return"deltaY"in e?e.deltaY:"wheelDeltaY"in e?-e.wheelDeltaY:"wheelDelta"in e?-e.wheelDelta:0},deltaZ:0,deltaMode:0}),I0=wt(z0),D0=[9,13,27,32],Cu=rn&&"CompositionEvent"in window,fo=null;rn&&"documentMode"in document&&(fo=document.documentMode);var j0=rn&&"TextEvent"in window&&!fo,Yf=rn&&(!Cu||fo&&8<fo&&11>=fo),Dc=String.fromCharCode(32),jc=!1;function Gf(e,t){switch(e){case"keyup":return D0.indexOf(t.keyCode)!==-1;case"keydown":return t.keyCode!==229;case"keypress":case"mousedown":case"focusout":return!0;default:return!1}}function Kf(e){return e=e.detail,typeof e=="object"&&"data"in e?e.data:null}var cr=!1;function V0(e,t){switch(e){case"compositionend":return Kf(t);case"keypress":return t.which!==32?null:(jc=!0,Dc);case"textInput":return e=t.data,e===Dc&&jc?null:e;default:return null}}function U0(e,t){if(cr)return e==="compositionend"||!Cu&&Gf(e,t)?(e=Qf(),wi=ku=vn=null,cr=!1,e):null;switch(e){case"paste":return null;case"keypress":if(!(t.ctrlKey||t.altKey||t.metaKey)||t.ctrlKey&&t.altKey){if(t.char&&1<t.char.length)return t.char;if(t.which)return String.fromCharCode(t.which)}return null;case"compositionend":return Yf&&t.locale!=="ko"?null:t.data;default:return null}}var B0={color:!0,date:!0,datetime:!0,"datetime-local":!0,email:!0,month:!0,number:!0,password:!0,range:!0,search:!0,tel:!0,text:!0,time:!0,url:!0,week:!0};function Vc(e){var t=e&&e.nodeName&&e.nodeName.toLowerCase();return t==="input"?!!B0[e.type]:t==="textarea"}function Xf(e,t,n,r){$f(r),t=Ii(t,"onChange"),0<t.length&&(n=new Su("onChange","change",null,n,r),e.push({event:n,listeners:t}))}var po=null,bo=null;function W0(e){ap(e,0)}function ws(e){var t=pr(e);if(kf(t))return e}function H0(e,t){if(e==="change")return t}var qf=!1;if(rn){var sl;if(rn){var ll="oninput"in document;if(!ll){var Uc=document.createElement("div");Uc.setAttribute("oninput","return;"),ll=typeof Uc.oninput=="function"}sl=ll}else sl=!1;qf=sl&&(!document.documentMode||9<document.documentMode)}function Bc(){po&&(po.detachEvent("onpropertychange",Jf),bo=po=null)}function Jf(e){if(e.propertyName==="value"&&ws(bo)){var t=[];Xf(t,bo,e,gu(e)),Nf(W0,t)}}function Z0(e,t,n){e==="focusin"?(Bc(),po=t,bo=n,po.attachEvent("onpropertychange",Jf)):e==="focusout"&&Bc()}function Q0(e){if(e==="selectionchange"||e==="keyup"||e==="keydown")return ws(bo)}function Y0(e,t){if(e==="click")return ws(t)}function G0(e,t){if(e==="input"||e==="change")return ws(t)}function K0(e,t){return e===t&&(e!==0||1/e===1/t)||e!==e&&t!==t}var zt=typeof Object.is=="function"?Object.is:K0;function $o(e,t){if(zt(e,t))return!0;if(typeof e!="object"||e===null||typeof t!="object"||t===null)return!1;var n=Object.keys(e),r=Object.keys(t);if(n.length!==r.length)return!1;for(r=0;r<n.length;r++){var o=n[r];if(!Ll.call(t,o)||!zt(e[o],t[o]))return!1}return!0}function Wc(e){for(;e&&e.firstChild;)e=e.firstChild;return e}function Hc(e,t){var n=Wc(e);e=0;for(var r;n;){if(n.nodeType===3){if(r=e+n.textContent.length,e<=t&&r>=t)return{node:n,offset:t-e};e=r}e:{for(;n;){if(n.nextSibling){n=n.nextSibling;break e}n=n.parentNode}n=void 0}n=Wc(n)}}function ep(e,t){return e&&t?e===t?!0:e&&e.nodeType===3?!1:t&&t.nodeType===3?ep(e,t.parentNode):"contains"in e?e.contains(t):e.compareDocumentPosition?!!(e.compareDocumentPosition(t)&16):!1:!1}function tp(){for(var e=window,t=Ri();t instanceof e.HTMLIFrameElement;){try{var n=typeof t.contentWindow.location.href=="string"}catch{n=!1}if(n)e=t.contentWindow;else break;t=Ri(e.document)}return t}function Eu(e){var t=e&&e.nodeName&&e.nodeName.toLowerCase();return t&&(t==="input"&&(e.type==="text"||e.type==="search"||e.type==="tel"||e.type==="url"||e.type==="password")||t==="textarea"||e.contentEditable==="true")}function X0(e){var t=tp(),n=e.focusedElem,r=e.selectionRange;if(t!==n&&n&&n.ownerDocument&&ep(n.ownerDocument.documentElement,n)){if(r!==null&&Eu(n)){if(t=r.start,e=r.end,e===void 0&&(e=t),"selectionStart"in n)n.selectionStart=t,n.selectionEnd=Math.min(e,n.value.length);else if(e=(t=n.ownerDocument||document)&&t.defaultView||window,e.getSelection){e=e.getSelection();var o=n.textContent.length,i=Math.min(r.start,o);r=r.end===void 0?i:Math.min(r.end,o),!e.extend&&i>r&&(o=r,r=i,i=o),o=Hc(n,i);var s=Hc(n,r);o&&s&&(e.rangeCount!==1||e.anchorNode!==o.node||e.anchorOffset!==o.offset||e.focusNode!==s.node||e.focusOffset!==s.offset)&&(t=t.createRange(),t.setStart(o.node,o.offset),e.removeAllRanges(),i>r?(e.addRange(t),e.extend(s.node,s.offset)):(t.setEnd(s.node,s.offset),e.addRange(t)))}}for(t=[],e=n;e=e.parentNode;)e.nodeType===1&&t.push({element:e,left:e.scrollLeft,top:e.scrollTop});for(typeof n.focus=="function"&&n.focus(),n=0;n<t.length;n++)e=t[n],e.element.scrollLeft=e.left,e.element.scrollTop=e.top}}var q0=rn&&"documentMode"in document&&11>=document.documentMode,dr=null,Jl=null,ho=null,ea=!1;function Zc(e,t,n){var r=n.window===n?n.document:n.nodeType===9?n:n.ownerDocument;ea||dr==null||dr!==Ri(r)||(r=dr,"selectionStart"in r&&Eu(r)?r={start:r.selectionStart,end:r.selectionEnd}:(r=(r.ownerDocument&&r.ownerDocument.defaultView||window).getSelection(),r={anchorNode:r.anchorNode,anchorOffset:r.anchorOffset,focusNode:r.focusNode,focusOffset:r.focusOffset}),ho&&$o(ho,r)||(ho=r,r=Ii(Jl,"onSelect"),0<r.length&&(t=new Su("onSelect","select",null,t,n),e.push({event:t,listeners:r}),t.target=dr)))}function oi(e,t){var n={};return n[e.toLowerCase()]=t.toLowerCase(),n["Webkit"+e]="webkit"+t,n["Moz"+e]="moz"+t,n}var fr={animationend:oi("Animation","AnimationEnd"),animationiteration:oi("Animation","AnimationIteration"),animationstart:oi("Animation","AnimationStart"),transitionend:oi("Transition","TransitionEnd")},al={},np={};rn&&(np=document.createElement("div").style,"AnimationEvent"in window||(delete fr.animationend.animation,delete fr.animationiteration.animation,delete fr.animationstart.animation),"TransitionEvent"in window||delete fr.transitionend.transition);function xs(e){if(al[e])return al[e];if(!fr[e])return e;var t=fr[e],n;for(n in t)if(t.hasOwnProperty(n)&&n in np)return al[e]=t[n];return e}var rp=xs("animationend"),op=xs("animationiteration"),ip=xs("animationstart"),sp=xs("transitionend"),lp=new Map,Qc="abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");function Mn(e,t){lp.set(e,t),nr(t,[e])}for(var ul=0;ul<Qc.length;ul++){var cl=Qc[ul],J0=cl.toLowerCase(),eg=cl[0].toUpperCase()+cl.slice(1);Mn(J0,"on"+eg)}Mn(rp,"onAnimationEnd");Mn(op,"onAnimationIteration");Mn(ip,"onAnimationStart");Mn("dblclick","onDoubleClick");Mn("focusin","onFocus");Mn("focusout","onBlur");Mn(sp,"onTransitionEnd");Nr("onMouseEnter",["mouseout","mouseover"]);Nr("onMouseLeave",["mouseout","mouseover"]);Nr("onPointerEnter",["pointerout","pointerover"]);Nr("onPointerLeave",["pointerout","pointerover"]);nr("onChange","change click focusin focusout input keydown keyup selectionchange".split(" "));nr("onSelect","focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));nr("onBeforeInput",["compositionend","keypress","textInput","paste"]);nr("onCompositionEnd","compositionend focusout keydown keypress keyup mousedown".split(" "));nr("onCompositionStart","compositionstart focusout keydown keypress keyup mousedown".split(" "));nr("onCompositionUpdate","compositionupdate focusout keydown keypress keyup mousedown".split(" "));var lo="abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),tg=new Set("cancel close invalid load scroll toggle".split(" ").concat(lo));function Yc(e,t,n){var r=e.type||"unknown-event";e.currentTarget=n,Jm(r,t,void 0,e),e.currentTarget=null}function ap(e,t){t=(t&4)!==0;for(var n=0;n<e.length;n++){var r=e[n],o=r.event;r=r.listeners;e:{var i=void 0;if(t)for(var s=r.length-1;0<=s;s--){var l=r[s],a=l.instance,u=l.currentTarget;if(l=l.listener,a!==i&&o.isPropagationStopped())break e;Yc(o,l,u),i=a}else for(s=0;s<r.length;s++){if(l=r[s],a=l.instance,u=l.currentTarget,l=l.listener,a!==i&&o.isPropagationStopped())break e;Yc(o,l,u),i=a}}}if(Fi)throw e=Gl,Fi=!1,Gl=null,e}function ke(e,t){var n=t[ia];n===void 0&&(n=t[ia]=new Set);var r=e+"__bubble";n.has(r)||(up(t,e,2,!1),n.add(r))}function dl(e,t,n){var r=0;t&&(r|=4),up(n,e,r,t)}var ii="_reactListening"+Math.random().toString(36).slice(2);function Po(e){if(!e[ii]){e[ii]=!0,gf.forEach(function(n){n!=="selectionchange"&&(tg.has(n)||dl(n,!1,e),dl(n,!0,e))});var t=e.nodeType===9?e:e.ownerDocument;t===null||t[ii]||(t[ii]=!0,dl("selectionchange",!1,t))}}function up(e,t,n,r){switch(Zf(t)){case 1:var o=m0;break;case 4:o=g0;break;default:o=xu}n=o.bind(null,t,n,e),o=void 0,!Yl||t!=="touchstart"&&t!=="touchmove"&&t!=="wheel"||(o=!0),r?o!==void 0?e.addEventListener(t,n,{capture:!0,passive:o}):e.addEventListener(t,n,!0):o!==void 0?e.addEventListener(t,n,{passive:o}):e.addEventListener(t,n,!1)}function fl(e,t,n,r,o){var i=r;if((t&1)===0&&(t&2)===0&&r!==null)e:for(;;){if(r===null)return;var s=r.tag;if(s===3||s===4){var l=r.stateNode.containerInfo;if(l===o||l.nodeType===8&&l.parentNode===o)break;if(s===4)for(s=r.return;s!==null;){var a=s.tag;if((a===3||a===4)&&(a=s.stateNode.containerInfo,a===o||a.nodeType===8&&a.parentNode===o))return;s=s.return}for(;l!==null;){if(s=Bn(l),s===null)return;if(a=s.tag,a===5||a===6){r=i=s;continue e}l=l.parentNode}}r=r.return}Nf(function(){var u=i,c=gu(n),d=[];e:{var p=lp.get(e);if(p!==void 0){var C=Su,S=e;switch(e){case"keypress":if(xi(n)===0)break e;case"keydown":case"keyup":C=R0;break;case"focusin":S="focus",C=il;break;case"focusout":S="blur",C=il;break;case"beforeblur":case"afterblur":C=il;break;case"click":if(n.button===2)break e;case"auxclick":case"dblclick":case"mousedown":case"mousemove":case"mouseup":case"mouseout":case"mouseover":case"contextmenu":C=Oc;break;case"drag":case"dragend":case"dragenter":case"dragexit":case"dragleave":case"dragover":case"dragstart":case"drop":C=w0;break;case"touchcancel":case"touchend":case"touchmove":case"touchstart":C=L0;break;case rp:case op:case ip:C=S0;break;case sp:C=O0;break;case"scroll":C=y0;break;case"wheel":C=I0;break;case"copy":case"cut":case"paste":C=C0;break;case"gotpointercapture":case"lostpointercapture":case"pointercancel":case"pointerdown":case"pointermove":case"pointerout":case"pointerover":case"pointerup":C=Ic}var E=(t&4)!==0,M=!E&&e==="scroll",h=E?p!==null?p+"Capture":null:p;E=[];for(var f=u,g;f!==null;){g=f;var x=g.stateNode;if(g.tag===5&&x!==null&&(g=x,h!==null&&(x=_o(f,h),x!=null&&E.push(Ao(f,x,g)))),M)break;f=f.return}0<E.length&&(p=new C(p,S,null,n,c),d.push({event:p,listeners:E}))}}if((t&7)===0){e:{if(p=e==="mouseover"||e==="pointerover",C=e==="mouseout"||e==="pointerout",p&&n!==Zl&&(S=n.relatedTarget||n.fromElement)&&(Bn(S)||S[on]))break e;if((C||p)&&(p=c.window===c?c:(p=c.ownerDocument)?p.defaultView||p.parentWindow:window,C?(S=n.relatedTarget||n.toElement,C=u,S=S?Bn(S):null,S!==null&&(M=rr(S),S!==M||S.tag!==5&&S.tag!==6)&&(S=null)):(C=null,S=u),C!==S)){if(E=Oc,x="onMouseLeave",h="onMouseEnter",f="mouse",(e==="pointerout"||e==="pointerover")&&(E=Ic,x="onPointerLeave",h="onPointerEnter",f="pointer"),M=C==null?p:pr(C),g=S==null?p:pr(S),p=new E(x,f+"leave",C,n,c),p.target=M,p.relatedTarget=g,x=null,Bn(c)===u&&(E=new E(h,f+"enter",S,n,c),E.target=g,E.relatedTarget=M,x=E),M=x,C&&S)t:{for(E=C,h=S,f=0,g=E;g;g=ir(g))f++;for(g=0,x=h;x;x=ir(x))g++;for(;0<f-g;)E=ir(E),f--;for(;0<g-f;)h=ir(h),g--;for(;f--;){if(E===h||h!==null&&E===h.alternate)break t;E=ir(E),h=ir(h)}E=null}else E=null;C!==null&&Gc(d,p,C,E,!1),S!==null&&M!==null&&Gc(d,M,S,E,!0)}}e:{if(p=u?pr(u):window,C=p.nodeName&&p.nodeName.toLowerCase(),C==="select"||C==="input"&&p.type==="file")var $=H0;else if(Vc(p))if(qf)$=G0;else{$=Q0;var z=Z0}else(C=p.nodeName)&&C.toLowerCase()==="input"&&(p.type==="checkbox"||p.type==="radio")&&($=Y0);if($&&($=$(e,u))){Xf(d,$,n,c);break e}z&&z(e,p,u),e==="focusout"&&(z=p._wrapperState)&&z.controlled&&p.type==="number"&&Vl(p,"number",p.value)}switch(z=u?pr(u):window,e){case"focusin":(Vc(z)||z.contentEditable==="true")&&(dr=z,Jl=u,ho=null);break;case"focusout":ho=Jl=dr=null;break;case"mousedown":ea=!0;break;case"contextmenu":case"mouseup":case"dragend":ea=!1,Zc(d,n,c);break;case"selectionchange":if(q0)break;case"keydown":case"keyup":Zc(d,n,c)}var D;if(Cu)e:{switch(e){case"compositionstart":var I="onCompositionStart";break e;case"compositionend":I="onCompositionEnd";break e;case"compositionupdate":I="onCompositionUpdate";break e}I=void 0}else cr?Gf(e,n)&&(I="onCompositionEnd"):e==="keydown"&&n.keyCode===229&&(I="onCompositionStart");I&&(Yf&&n.locale!=="ko"&&(cr||I!=="onCompositionStart"?I==="onCompositionEnd"&&cr&&(D=Qf()):(vn=c,ku="value"in vn?vn.value:vn.textContent,cr=!0)),z=Ii(u,I),0<z.length&&(I=new zc(I,e,null,n,c),d.push({event:I,listeners:z}),D?I.data=D:(D=Kf(n),D!==null&&(I.data=D)))),(D=j0?V0(e,n):U0(e,n))&&(u=Ii(u,"onBeforeInput"),0<u.length&&(c=new zc("onBeforeInput","beforeinput",null,n,c),d.push({event:c,listeners:u}),c.data=D))}ap(d,t)})}function Ao(e,t,n){return{instance:e,listener:t,currentTarget:n}}function Ii(e,t){for(var n=t+"Capture",r=[];e!==null;){var o=e,i=o.stateNode;o.tag===5&&i!==null&&(o=i,i=_o(e,n),i!=null&&r.unshift(Ao(e,i,o)),i=_o(e,t),i!=null&&r.push(Ao(e,i,o))),e=e.return}return r}function ir(e){if(e===null)return null;do e=e.return;while(e&&e.tag!==5);return e||null}function Gc(e,t,n,r,o){for(var i=t._reactName,s=[];n!==null&&n!==r;){var l=n,a=l.alternate,u=l.stateNode;if(a!==null&&a===r)break;l.tag===5&&u!==null&&(l=u,o?(a=_o(n,i),a!=null&&s.unshift(Ao(n,a,l))):o||(a=_o(n,i),a!=null&&s.push(Ao(n,a,l)))),n=n.return}s.length!==0&&e.push({event:t,listeners:s})}var ng=/\r\n?/g,rg=/\u0000|\uFFFD/g;function Kc(e){return(typeof e=="string"?e:""+e).replace(ng,`
`).replace(rg,"")}function si(e,t,n){if(t=Kc(t),Kc(e)!==t&&n)throw Error(A(425))}function Di(){}var ta=null,na=null;function ra(e,t){return e==="textarea"||e==="noscript"||typeof t.children=="string"||typeof t.children=="number"||typeof t.dangerouslySetInnerHTML=="object"&&t.dangerouslySetInnerHTML!==null&&t.dangerouslySetInnerHTML.__html!=null}var oa=typeof setTimeout=="function"?setTimeout:void 0,og=typeof clearTimeout=="function"?clearTimeout:void 0,Xc=typeof Promise=="function"?Promise:void 0,ig=typeof queueMicrotask=="function"?queueMicrotask:typeof Xc<"u"?function(e){return Xc.resolve(null).then(e).catch(sg)}:oa;function sg(e){setTimeout(function(){throw e})}function pl(e,t){var n=t,r=0;do{var o=n.nextSibling;if(e.removeChild(n),o&&o.nodeType===8)if(n=o.data,n==="/$"){if(r===0){e.removeChild(o),To(t);return}r--}else n!=="$"&&n!=="$?"&&n!=="$!"||r++;n=o}while(n);To(t)}function _n(e){for(;e!=null;e=e.nextSibling){var t=e.nodeType;if(t===1||t===3)break;if(t===8){if(t=e.data,t==="$"||t==="$!"||t==="$?")break;if(t==="/$")return null}}return e}function qc(e){e=e.previousSibling;for(var t=0;e;){if(e.nodeType===8){var n=e.data;if(n==="$"||n==="$!"||n==="$?"){if(t===0)return e;t--}else n==="/$"&&t++}e=e.previousSibling}return null}var Qr=Math.random().toString(36).slice(2),Ut="__reactFiber$"+Qr,Ro="__reactProps$"+Qr,on="__reactContainer$"+Qr,ia="__reactEvents$"+Qr,lg="__reactListeners$"+Qr,ag="__reactHandles$"+Qr;function Bn(e){var t=e[Ut];if(t)return t;for(var n=e.parentNode;n;){if(t=n[on]||n[Ut]){if(n=t.alternate,t.child!==null||n!==null&&n.child!==null)for(e=qc(e);e!==null;){if(n=e[Ut])return n;e=qc(e)}return t}e=n,n=e.parentNode}return null}function Wo(e){return e=e[Ut]||e[on],!e||e.tag!==5&&e.tag!==6&&e.tag!==13&&e.tag!==3?null:e}function pr(e){if(e.tag===5||e.tag===6)return e.stateNode;throw Error(A(33))}function ks(e){return e[Ro]||null}var sa=[],hr=-1;function On(e){return{current:e}}function _e(e){0>hr||(e.current=sa[hr],sa[hr]=null,hr--)}function xe(e,t){hr++,sa[hr]=e.current,e.current=t}var Rn={},qe=On(Rn),at=On(!1),Yn=Rn;function Fr(e,t){var n=e.type.contextTypes;if(!n)return Rn;var r=e.stateNode;if(r&&r.__reactInternalMemoizedUnmaskedChildContext===t)return r.__reactInternalMemoizedMaskedChildContext;var o={},i;for(i in n)o[i]=t[i];return r&&(e=e.stateNode,e.__reactInternalMemoizedUnmaskedChildContext=t,e.__reactInternalMemoizedMaskedChildContext=o),o}function ut(e){return e=e.childContextTypes,e!=null}function ji(){_e(at),_e(qe)}function Jc(e,t,n){if(qe.current!==Rn)throw Error(A(168));xe(qe,t),xe(at,n)}function cp(e,t,n){var r=e.stateNode;if(t=t.childContextTypes,typeof r.getChildContext!="function")return n;r=r.getChildContext();for(var o in r)if(!(o in t))throw Error(A(108,Zm(e)||"Unknown",o));return Ae({},n,r)}function Vi(e){return e=(e=e.stateNode)&&e.__reactInternalMemoizedMergedChildContext||Rn,Yn=qe.current,xe(qe,e),xe(at,at.current),!0}function ed(e,t,n){var r=e.stateNode;if(!r)throw Error(A(169));n?(e=cp(e,t,Yn),r.__reactInternalMemoizedMergedChildContext=e,_e(at),_e(qe),xe(qe,e)):_e(at),xe(at,n)}var Xt=null,Ss=!1,hl=!1;function dp(e){Xt===null?Xt=[e]:Xt.push(e)}function ug(e){Ss=!0,dp(e)}function zn(){if(!hl&&Xt!==null){hl=!0;var e=0,t=ge;try{var n=Xt;for(ge=1;e<n.length;e++){var r=n[e];do r=r(!0);while(r!==null)}Xt=null,Ss=!1}catch(o){throw Xt!==null&&(Xt=Xt.slice(e+1)),Of(yu,zn),o}finally{ge=t,hl=!1}}return null}var mr=[],gr=0,Ui=null,Bi=0,_t=[],Ct=0,Gn=null,qt=1,Jt="";function Dn(e,t){mr[gr++]=Bi,mr[gr++]=Ui,Ui=e,Bi=t}function fp(e,t,n){_t[Ct++]=qt,_t[Ct++]=Jt,_t[Ct++]=Gn,Gn=e;var r=qt;e=Jt;var o=32-Mt(r)-1;r&=~(1<<o),n+=1;var i=32-Mt(t)+o;if(30<i){var s=o-o%5;i=(r&(1<<s)-1).toString(32),r>>=s,o-=s,qt=1<<32-Mt(t)+o|n<<o|r,Jt=i+e}else qt=1<<i|n<<o|r,Jt=e}function Tu(e){e.return!==null&&(Dn(e,1),fp(e,1,0))}function bu(e){for(;e===Ui;)Ui=mr[--gr],mr[gr]=null,Bi=mr[--gr],mr[gr]=null;for(;e===Gn;)Gn=_t[--Ct],_t[Ct]=null,Jt=_t[--Ct],_t[Ct]=null,qt=_t[--Ct],_t[Ct]=null}var gt=null,mt=null,Ee=!1,Ft=null;function pp(e,t){var n=Et(5,null,null,0);n.elementType="DELETED",n.stateNode=t,n.return=e,t=e.deletions,t===null?(e.deletions=[n],e.flags|=16):t.push(n)}function td(e,t){switch(e.tag){case 5:var n=e.type;return t=t.nodeType!==1||n.toLowerCase()!==t.nodeName.toLowerCase()?null:t,t!==null?(e.stateNode=t,gt=e,mt=_n(t.firstChild),!0):!1;case 6:return t=e.pendingProps===""||t.nodeType!==3?null:t,t!==null?(e.stateNode=t,gt=e,mt=null,!0):!1;case 13:return t=t.nodeType!==8?null:t,t!==null?(n=Gn!==null?{id:qt,overflow:Jt}:null,e.memoizedState={dehydrated:t,treeContext:n,retryLane:1073741824},n=Et(18,null,null,0),n.stateNode=t,n.return=e,e.child=n,gt=e,mt=null,!0):!1;default:return!1}}function la(e){return(e.mode&1)!==0&&(e.flags&128)===0}function aa(e){if(Ee){var t=mt;if(t){var n=t;if(!td(e,t)){if(la(e))throw Error(A(418));t=_n(n.nextSibling);var r=gt;t&&td(e,t)?pp(r,n):(e.flags=e.flags&-4097|2,Ee=!1,gt=e)}}else{if(la(e))throw Error(A(418));e.flags=e.flags&-4097|2,Ee=!1,gt=e}}}function nd(e){for(e=e.return;e!==null&&e.tag!==5&&e.tag!==3&&e.tag!==13;)e=e.return;gt=e}function li(e){if(e!==gt)return!1;if(!Ee)return nd(e),Ee=!0,!1;var t;if((t=e.tag!==3)&&!(t=e.tag!==5)&&(t=e.type,t=t!=="head"&&t!=="body"&&!ra(e.type,e.memoizedProps)),t&&(t=mt)){if(la(e))throw hp(),Error(A(418));for(;t;)pp(e,t),t=_n(t.nextSibling)}if(nd(e),e.tag===13){if(e=e.memoizedState,e=e!==null?e.dehydrated:null,!e)throw Error(A(317));e:{for(e=e.nextSibling,t=0;e;){if(e.nodeType===8){var n=e.data;if(n==="/$"){if(t===0){mt=_n(e.nextSibling);break e}t--}else n!=="$"&&n!=="$!"&&n!=="$?"||t++}e=e.nextSibling}mt=null}}else mt=gt?_n(e.stateNode.nextSibling):null;return!0}function hp(){for(var e=mt;e;)e=_n(e.nextSibling)}function Lr(){mt=gt=null,Ee=!1}function $u(e){Ft===null?Ft=[e]:Ft.push(e)}var cg=cn.ReactCurrentBatchConfig;function Rt(e,t){if(e&&e.defaultProps){t=Ae({},t),e=e.defaultProps;for(var n in e)t[n]===void 0&&(t[n]=e[n]);return t}return t}var Wi=On(null),Hi=null,yr=null,Pu=null;function Au(){Pu=yr=Hi=null}function Ru(e){var t=Wi.current;_e(Wi),e._currentValue=t}function ua(e,t,n){for(;e!==null;){var r=e.alternate;if((e.childLanes&t)!==t?(e.childLanes|=t,r!==null&&(r.childLanes|=t)):r!==null&&(r.childLanes&t)!==t&&(r.childLanes|=t),e===n)break;e=e.return}}function $r(e,t){Hi=e,Pu=yr=null,e=e.dependencies,e!==null&&e.firstContext!==null&&((e.lanes&t)!==0&&(lt=!0),e.firstContext=null)}function bt(e){var t=e._currentValue;if(Pu!==e)if(e={context:e,memoizedValue:t,next:null},yr===null){if(Hi===null)throw Error(A(308));yr=e,Hi.dependencies={lanes:0,firstContext:e}}else yr=yr.next=e;return t}var Wn=null;function Nu(e){Wn===null?Wn=[e]:Wn.push(e)}function mp(e,t,n,r){var o=t.interleaved;return o===null?(n.next=n,Nu(t)):(n.next=o.next,o.next=n),t.interleaved=n,sn(e,r)}function sn(e,t){e.lanes|=t;var n=e.alternate;for(n!==null&&(n.lanes|=t),n=e,e=e.return;e!==null;)e.childLanes|=t,n=e.alternate,n!==null&&(n.childLanes|=t),n=e,e=e.return;return n.tag===3?n.stateNode:null}var mn=!1;function Fu(e){e.updateQueue={baseState:e.memoizedState,firstBaseUpdate:null,lastBaseUpdate:null,shared:{pending:null,interleaved:null,lanes:0},effects:null}}function gp(e,t){e=e.updateQueue,t.updateQueue===e&&(t.updateQueue={baseState:e.baseState,firstBaseUpdate:e.firstBaseUpdate,lastBaseUpdate:e.lastBaseUpdate,shared:e.shared,effects:e.effects})}function tn(e,t){return{eventTime:e,lane:t,tag:0,payload:null,callback:null,next:null}}function Cn(e,t,n){var r=e.updateQueue;if(r===null)return null;if(r=r.shared,(ue&2)!==0){var o=r.pending;return o===null?t.next=t:(t.next=o.next,o.next=t),r.pending=t,sn(e,n)}return o=r.interleaved,o===null?(t.next=t,Nu(r)):(t.next=o.next,o.next=t),r.interleaved=t,sn(e,n)}function ki(e,t,n){if(t=t.updateQueue,t!==null&&(t=t.shared,(n&4194240)!==0)){var r=t.lanes;r&=e.pendingLanes,n|=r,t.lanes=n,vu(e,n)}}function rd(e,t){var n=e.updateQueue,r=e.alternate;if(r!==null&&(r=r.updateQueue,n===r)){var o=null,i=null;if(n=n.firstBaseUpdate,n!==null){do{var s={eventTime:n.eventTime,lane:n.lane,tag:n.tag,payload:n.payload,callback:n.callback,next:null};i===null?o=i=s:i=i.next=s,n=n.next}while(n!==null);i===null?o=i=t:i=i.next=t}else o=i=t;n={baseState:r.baseState,firstBaseUpdate:o,lastBaseUpdate:i,shared:r.shared,effects:r.effects},e.updateQueue=n;return}e=n.lastBaseUpdate,e===null?n.firstBaseUpdate=t:e.next=t,n.lastBaseUpdate=t}function Zi(e,t,n,r){var o=e.updateQueue;mn=!1;var i=o.firstBaseUpdate,s=o.lastBaseUpdate,l=o.shared.pending;if(l!==null){o.shared.pending=null;var a=l,u=a.next;a.next=null,s===null?i=u:s.next=u,s=a;var c=e.alternate;c!==null&&(c=c.updateQueue,l=c.lastBaseUpdate,l!==s&&(l===null?c.firstBaseUpdate=u:l.next=u,c.lastBaseUpdate=a))}if(i!==null){var d=o.baseState;s=0,c=u=a=null,l=i;do{var p=l.lane,C=l.eventTime;if((r&p)===p){c!==null&&(c=c.next={eventTime:C,lane:0,tag:l.tag,payload:l.payload,callback:l.callback,next:null});e:{var S=e,E=l;switch(p=t,C=n,E.tag){case 1:if(S=E.payload,typeof S=="function"){d=S.call(C,d,p);break e}d=S;break e;case 3:S.flags=S.flags&-65537|128;case 0:if(S=E.payload,p=typeof S=="function"?S.call(C,d,p):S,p==null)break e;d=Ae({},d,p);break e;case 2:mn=!0}}l.callback!==null&&l.lane!==0&&(e.flags|=64,p=o.effects,p===null?o.effects=[l]:p.push(l))}else C={eventTime:C,lane:p,tag:l.tag,payload:l.payload,callback:l.callback,next:null},c===null?(u=c=C,a=d):c=c.next=C,s|=p;if(l=l.next,l===null){if(l=o.shared.pending,l===null)break;p=l,l=p.next,p.next=null,o.lastBaseUpdate=p,o.shared.pending=null}}while(1);if(c===null&&(a=d),o.baseState=a,o.firstBaseUpdate=u,o.lastBaseUpdate=c,t=o.shared.interleaved,t!==null){o=t;do s|=o.lane,o=o.next;while(o!==t)}else i===null&&(o.shared.lanes=0);Xn|=s,e.lanes=s,e.memoizedState=d}}function od(e,t,n){if(e=t.effects,t.effects=null,e!==null)for(t=0;t<e.length;t++){var r=e[t],o=r.callback;if(o!==null){if(r.callback=null,r=n,typeof o!="function")throw Error(A(191,o));o.call(r)}}}var yp=new mf.Component().refs;function ca(e,t,n,r){t=e.memoizedState,n=n(r,t),n=n==null?t:Ae({},t,n),e.memoizedState=n,e.lanes===0&&(e.updateQueue.baseState=n)}var _s={isMounted:function(e){return(e=e._reactInternals)?rr(e)===e:!1},enqueueSetState:function(e,t,n){e=e._reactInternals;var r=nt(),o=Tn(e),i=tn(r,o);i.payload=t,n!=null&&(i.callback=n),t=Cn(e,i,o),t!==null&&(Ot(t,e,o,r),ki(t,e,o))},enqueueReplaceState:function(e,t,n){e=e._reactInternals;var r=nt(),o=Tn(e),i=tn(r,o);i.tag=1,i.payload=t,n!=null&&(i.callback=n),t=Cn(e,i,o),t!==null&&(Ot(t,e,o,r),ki(t,e,o))},enqueueForceUpdate:function(e,t){e=e._reactInternals;var n=nt(),r=Tn(e),o=tn(n,r);o.tag=2,t!=null&&(o.callback=t),t=Cn(e,o,r),t!==null&&(Ot(t,e,r,n),ki(t,e,r))}};function id(e,t,n,r,o,i,s){return e=e.stateNode,typeof e.shouldComponentUpdate=="function"?e.shouldComponentUpdate(r,i,s):t.prototype&&t.prototype.isPureReactComponent?!$o(n,r)||!$o(o,i):!0}function vp(e,t,n){var r=!1,o=Rn,i=t.contextType;return typeof i=="object"&&i!==null?i=bt(i):(o=ut(t)?Yn:qe.current,r=t.contextTypes,i=(r=r!=null)?Fr(e,o):Rn),t=new t(n,i),e.memoizedState=t.state!==null&&t.state!==void 0?t.state:null,t.updater=_s,e.stateNode=t,t._reactInternals=e,r&&(e=e.stateNode,e.__reactInternalMemoizedUnmaskedChildContext=o,e.__reactInternalMemoizedMaskedChildContext=i),t}function sd(e,t,n,r){e=t.state,typeof t.componentWillReceiveProps=="function"&&t.componentWillReceiveProps(n,r),typeof t.UNSAFE_componentWillReceiveProps=="function"&&t.UNSAFE_componentWillReceiveProps(n,r),t.state!==e&&_s.enqueueReplaceState(t,t.state,null)}function da(e,t,n,r){var o=e.stateNode;o.props=n,o.state=e.memoizedState,o.refs=yp,Fu(e);var i=t.contextType;typeof i=="object"&&i!==null?o.context=bt(i):(i=ut(t)?Yn:qe.current,o.context=Fr(e,i)),o.state=e.memoizedState,i=t.getDerivedStateFromProps,typeof i=="function"&&(ca(e,t,i,n),o.state=e.memoizedState),typeof t.getDerivedStateFromProps=="function"||typeof o.getSnapshotBeforeUpdate=="function"||typeof o.UNSAFE_componentWillMount!="function"&&typeof o.componentWillMount!="function"||(t=o.state,typeof o.componentWillMount=="function"&&o.componentWillMount(),typeof o.UNSAFE_componentWillMount=="function"&&o.UNSAFE_componentWillMount(),t!==o.state&&_s.enqueueReplaceState(o,o.state,null),Zi(e,n,o,r),o.state=e.memoizedState),typeof o.componentDidMount=="function"&&(e.flags|=4194308)}function eo(e,t,n){if(e=n.ref,e!==null&&typeof e!="function"&&typeof e!="object"){if(n._owner){if(n=n._owner,n){if(n.tag!==1)throw Error(A(309));var r=n.stateNode}if(!r)throw Error(A(147,e));var o=r,i=""+e;return t!==null&&t.ref!==null&&typeof t.ref=="function"&&t.ref._stringRef===i?t.ref:(t=function(s){var l=o.refs;l===yp&&(l=o.refs={}),s===null?delete l[i]:l[i]=s},t._stringRef=i,t)}if(typeof e!="string")throw Error(A(284));if(!n._owner)throw Error(A(290,e))}return e}function ai(e,t){throw e=Object.prototype.toString.call(t),Error(A(31,e==="[object Object]"?"object with keys {"+Object.keys(t).join(", ")+"}":e))}function ld(e){var t=e._init;return t(e._payload)}function wp(e){function t(h,f){if(e){var g=h.deletions;g===null?(h.deletions=[f],h.flags|=16):g.push(f)}}function n(h,f){if(!e)return null;for(;f!==null;)t(h,f),f=f.sibling;return null}function r(h,f){for(h=new Map;f!==null;)f.key!==null?h.set(f.key,f):h.set(f.index,f),f=f.sibling;return h}function o(h,f){return h=bn(h,f),h.index=0,h.sibling=null,h}function i(h,f,g){return h.index=g,e?(g=h.alternate,g!==null?(g=g.index,g<f?(h.flags|=2,f):g):(h.flags|=2,f)):(h.flags|=1048576,f)}function s(h){return e&&h.alternate===null&&(h.flags|=2),h}function l(h,f,g,x){return f===null||f.tag!==6?(f=kl(g,h.mode,x),f.return=h,f):(f=o(f,g),f.return=h,f)}function a(h,f,g,x){var $=g.type;return $===ur?c(h,f,g.props.children,x,g.key):f!==null&&(f.elementType===$||typeof $=="object"&&$!==null&&$.$$typeof===hn&&ld($)===f.type)?(x=o(f,g.props),x.ref=eo(h,f,g),x.return=h,x):(x=bi(g.type,g.key,g.props,null,h.mode,x),x.ref=eo(h,f,g),x.return=h,x)}function u(h,f,g,x){return f===null||f.tag!==4||f.stateNode.containerInfo!==g.containerInfo||f.stateNode.implementation!==g.implementation?(f=Sl(g,h.mode,x),f.return=h,f):(f=o(f,g.children||[]),f.return=h,f)}function c(h,f,g,x,$){return f===null||f.tag!==7?(f=Qn(g,h.mode,x,$),f.return=h,f):(f=o(f,g),f.return=h,f)}function d(h,f,g){if(typeof f=="string"&&f!==""||typeof f=="number")return f=kl(""+f,h.mode,g),f.return=h,f;if(typeof f=="object"&&f!==null){switch(f.$$typeof){case Xo:return g=bi(f.type,f.key,f.props,null,h.mode,g),g.ref=eo(h,null,f),g.return=h,g;case ar:return f=Sl(f,h.mode,g),f.return=h,f;case hn:var x=f._init;return d(h,x(f._payload),g)}if(io(f)||Gr(f))return f=Qn(f,h.mode,g,null),f.return=h,f;ai(h,f)}return null}function p(h,f,g,x){var $=f!==null?f.key:null;if(typeof g=="string"&&g!==""||typeof g=="number")return $!==null?null:l(h,f,""+g,x);if(typeof g=="object"&&g!==null){switch(g.$$typeof){case Xo:return g.key===$?a(h,f,g,x):null;case ar:return g.key===$?u(h,f,g,x):null;case hn:return $=g._init,p(h,f,$(g._payload),x)}if(io(g)||Gr(g))return $!==null?null:c(h,f,g,x,null);ai(h,g)}return null}function C(h,f,g,x,$){if(typeof x=="string"&&x!==""||typeof x=="number")return h=h.get(g)||null,l(f,h,""+x,$);if(typeof x=="object"&&x!==null){switch(x.$$typeof){case Xo:return h=h.get(x.key===null?g:x.key)||null,a(f,h,x,$);case ar:return h=h.get(x.key===null?g:x.key)||null,u(f,h,x,$);case hn:var z=x._init;return C(h,f,g,z(x._payload),$)}if(io(x)||Gr(x))return h=h.get(g)||null,c(f,h,x,$,null);ai(f,x)}return null}function S(h,f,g,x){for(var $=null,z=null,D=f,I=f=0,te=null;D!==null&&I<g.length;I++){D.index>I?(te=D,D=null):te=D.sibling;var K=p(h,D,g[I],x);if(K===null){D===null&&(D=te);break}e&&D&&K.alternate===null&&t(h,D),f=i(K,f,I),z===null?$=K:z.sibling=K,z=K,D=te}if(I===g.length)return n(h,D),Ee&&Dn(h,I),$;if(D===null){for(;I<g.length;I++)D=d(h,g[I],x),D!==null&&(f=i(D,f,I),z===null?$=D:z.sibling=D,z=D);return Ee&&Dn(h,I),$}for(D=r(h,D);I<g.length;I++)te=C(D,h,I,g[I],x),te!==null&&(e&&te.alternate!==null&&D.delete(te.key===null?I:te.key),f=i(te,f,I),z===null?$=te:z.sibling=te,z=te);return e&&D.forEach(function(Z){return t(h,Z)}),Ee&&Dn(h,I),$}function E(h,f,g,x){var $=Gr(g);if(typeof $!="function")throw Error(A(150));if(g=$.call(g),g==null)throw Error(A(151));for(var z=$=null,D=f,I=f=0,te=null,K=g.next();D!==null&&!K.done;I++,K=g.next()){D.index>I?(te=D,D=null):te=D.sibling;var Z=p(h,D,K.value,x);if(Z===null){D===null&&(D=te);break}e&&D&&Z.alternate===null&&t(h,D),f=i(Z,f,I),z===null?$=Z:z.sibling=Z,z=Z,D=te}if(K.done)return n(h,D),Ee&&Dn(h,I),$;if(D===null){for(;!K.done;I++,K=g.next())K=d(h,K.value,x),K!==null&&(f=i(K,f,I),z===null?$=K:z.sibling=K,z=K);return Ee&&Dn(h,I),$}for(D=r(h,D);!K.done;I++,K=g.next())K=C(D,h,I,K.value,x),K!==null&&(e&&K.alternate!==null&&D.delete(K.key===null?I:K.key),f=i(K,f,I),z===null?$=K:z.sibling=K,z=K);return e&&D.forEach(function(Y){return t(h,Y)}),Ee&&Dn(h,I),$}function M(h,f,g,x){if(typeof g=="object"&&g!==null&&g.type===ur&&g.key===null&&(g=g.props.children),typeof g=="object"&&g!==null){switch(g.$$typeof){case Xo:e:{for(var $=g.key,z=f;z!==null;){if(z.key===$){if($=g.type,$===ur){if(z.tag===7){n(h,z.sibling),f=o(z,g.props.children),f.return=h,h=f;break e}}else if(z.elementType===$||typeof $=="object"&&$!==null&&$.$$typeof===hn&&ld($)===z.type){n(h,z.sibling),f=o(z,g.props),f.ref=eo(h,z,g),f.return=h,h=f;break e}n(h,z);break}else t(h,z);z=z.sibling}g.type===ur?(f=Qn(g.props.children,h.mode,x,g.key),f.return=h,h=f):(x=bi(g.type,g.key,g.props,null,h.mode,x),x.ref=eo(h,f,g),x.return=h,h=x)}return s(h);case ar:e:{for(z=g.key;f!==null;){if(f.key===z)if(f.tag===4&&f.stateNode.containerInfo===g.containerInfo&&f.stateNode.implementation===g.implementation){n(h,f.sibling),f=o(f,g.children||[]),f.return=h,h=f;break e}else{n(h,f);break}else t(h,f);f=f.sibling}f=Sl(g,h.mode,x),f.return=h,h=f}return s(h);case hn:return z=g._init,M(h,f,z(g._payload),x)}if(io(g))return S(h,f,g,x);if(Gr(g))return E(h,f,g,x);ai(h,g)}return typeof g=="string"&&g!==""||typeof g=="number"?(g=""+g,f!==null&&f.tag===6?(n(h,f.sibling),f=o(f,g),f.return=h,h=f):(n(h,f),f=kl(g,h.mode,x),f.return=h,h=f),s(h)):n(h,f)}return M}var Mr=wp(!0),xp=wp(!1),Ho={},Zt=On(Ho),No=On(Ho),Fo=On(Ho);function Hn(e){if(e===Ho)throw Error(A(174));return e}function Lu(e,t){switch(xe(Fo,t),xe(No,e),xe(Zt,Ho),e=t.nodeType,e){case 9:case 11:t=(t=t.documentElement)?t.namespaceURI:Bl(null,"");break;default:e=e===8?t.parentNode:t,t=e.namespaceURI||null,e=e.tagName,t=Bl(t,e)}_e(Zt),xe(Zt,t)}function Or(){_e(Zt),_e(No),_e(Fo)}function kp(e){Hn(Fo.current);var t=Hn(Zt.current),n=Bl(t,e.type);t!==n&&(xe(No,e),xe(Zt,n))}function Mu(e){No.current===e&&(_e(Zt),_e(No))}var $e=On(0);function Qi(e){for(var t=e;t!==null;){if(t.tag===13){var n=t.memoizedState;if(n!==null&&(n=n.dehydrated,n===null||n.data==="$?"||n.data==="$!"))return t}else if(t.tag===19&&t.memoizedProps.revealOrder!==void 0){if((t.flags&128)!==0)return t}else if(t.child!==null){t.child.return=t,t=t.child;continue}if(t===e)break;for(;t.sibling===null;){if(t.return===null||t.return===e)return null;t=t.return}t.sibling.return=t.return,t=t.sibling}return null}var ml=[];function Ou(){for(var e=0;e<ml.length;e++)ml[e]._workInProgressVersionPrimary=null;ml.length=0}var Si=cn.ReactCurrentDispatcher,gl=cn.ReactCurrentBatchConfig,Kn=0,Pe=null,Ie=null,Ve=null,Yi=!1,mo=!1,Lo=0,dg=0;function Ge(){throw Error(A(321))}function zu(e,t){if(t===null)return!1;for(var n=0;n<t.length&&n<e.length;n++)if(!zt(e[n],t[n]))return!1;return!0}function Iu(e,t,n,r,o,i){if(Kn=i,Pe=t,t.memoizedState=null,t.updateQueue=null,t.lanes=0,Si.current=e===null||e.memoizedState===null?mg:gg,e=n(r,o),mo){i=0;do{if(mo=!1,Lo=0,25<=i)throw Error(A(301));i+=1,Ve=Ie=null,t.updateQueue=null,Si.current=yg,e=n(r,o)}while(mo)}if(Si.current=Gi,t=Ie!==null&&Ie.next!==null,Kn=0,Ve=Ie=Pe=null,Yi=!1,t)throw Error(A(300));return e}function Du(){var e=Lo!==0;return Lo=0,e}function jt(){var e={memoizedState:null,baseState:null,baseQueue:null,queue:null,next:null};return Ve===null?Pe.memoizedState=Ve=e:Ve=Ve.next=e,Ve}function $t(){if(Ie===null){var e=Pe.alternate;e=e!==null?e.memoizedState:null}else e=Ie.next;var t=Ve===null?Pe.memoizedState:Ve.next;if(t!==null)Ve=t,Ie=e;else{if(e===null)throw Error(A(310));Ie=e,e={memoizedState:Ie.memoizedState,baseState:Ie.baseState,baseQueue:Ie.baseQueue,queue:Ie.queue,next:null},Ve===null?Pe.memoizedState=Ve=e:Ve=Ve.next=e}return Ve}function Mo(e,t){return typeof t=="function"?t(e):t}function yl(e){var t=$t(),n=t.queue;if(n===null)throw Error(A(311));n.lastRenderedReducer=e;var r=Ie,o=r.baseQueue,i=n.pending;if(i!==null){if(o!==null){var s=o.next;o.next=i.next,i.next=s}r.baseQueue=o=i,n.pending=null}if(o!==null){i=o.next,r=r.baseState;var l=s=null,a=null,u=i;do{var c=u.lane;if((Kn&c)===c)a!==null&&(a=a.next={lane:0,action:u.action,hasEagerState:u.hasEagerState,eagerState:u.eagerState,next:null}),r=u.hasEagerState?u.eagerState:e(r,u.action);else{var d={lane:c,action:u.action,hasEagerState:u.hasEagerState,eagerState:u.eagerState,next:null};a===null?(l=a=d,s=r):a=a.next=d,Pe.lanes|=c,Xn|=c}u=u.next}while(u!==null&&u!==i);a===null?s=r:a.next=l,zt(r,t.memoizedState)||(lt=!0),t.memoizedState=r,t.baseState=s,t.baseQueue=a,n.lastRenderedState=r}if(e=n.interleaved,e!==null){o=e;do i=o.lane,Pe.lanes|=i,Xn|=i,o=o.next;while(o!==e)}else o===null&&(n.lanes=0);return[t.memoizedState,n.dispatch]}function vl(e){var t=$t(),n=t.queue;if(n===null)throw Error(A(311));n.lastRenderedReducer=e;var r=n.dispatch,o=n.pending,i=t.memoizedState;if(o!==null){n.pending=null;var s=o=o.next;do i=e(i,s.action),s=s.next;while(s!==o);zt(i,t.memoizedState)||(lt=!0),t.memoizedState=i,t.baseQueue===null&&(t.baseState=i),n.lastRenderedState=i}return[i,r]}function Sp(){}function _p(e,t){var n=Pe,r=$t(),o=t(),i=!zt(r.memoizedState,o);if(i&&(r.memoizedState=o,lt=!0),r=r.queue,ju(Tp.bind(null,n,r,e),[e]),r.getSnapshot!==t||i||Ve!==null&&Ve.memoizedState.tag&1){if(n.flags|=2048,Oo(9,Ep.bind(null,n,r,o,t),void 0,null),Ue===null)throw Error(A(349));(Kn&30)!==0||Cp(n,t,o)}return o}function Cp(e,t,n){e.flags|=16384,e={getSnapshot:t,value:n},t=Pe.updateQueue,t===null?(t={lastEffect:null,stores:null},Pe.updateQueue=t,t.stores=[e]):(n=t.stores,n===null?t.stores=[e]:n.push(e))}function Ep(e,t,n,r){t.value=n,t.getSnapshot=r,bp(t)&&$p(e)}function Tp(e,t,n){return n(function(){bp(t)&&$p(e)})}function bp(e){var t=e.getSnapshot;e=e.value;try{var n=t();return!zt(e,n)}catch{return!0}}function $p(e){var t=sn(e,1);t!==null&&Ot(t,e,1,-1)}function ad(e){var t=jt();return typeof e=="function"&&(e=e()),t.memoizedState=t.baseState=e,e={pending:null,interleaved:null,lanes:0,dispatch:null,lastRenderedReducer:Mo,lastRenderedState:e},t.queue=e,e=e.dispatch=hg.bind(null,Pe,e),[t.memoizedState,e]}function Oo(e,t,n,r){return e={tag:e,create:t,destroy:n,deps:r,next:null},t=Pe.updateQueue,t===null?(t={lastEffect:null,stores:null},Pe.updateQueue=t,t.lastEffect=e.next=e):(n=t.lastEffect,n===null?t.lastEffect=e.next=e:(r=n.next,n.next=e,e.next=r,t.lastEffect=e)),e}function Pp(){return $t().memoizedState}function _i(e,t,n,r){var o=jt();Pe.flags|=e,o.memoizedState=Oo(1|t,n,void 0,r===void 0?null:r)}function Cs(e,t,n,r){var o=$t();r=r===void 0?null:r;var i=void 0;if(Ie!==null){var s=Ie.memoizedState;if(i=s.destroy,r!==null&&zu(r,s.deps)){o.memoizedState=Oo(t,n,i,r);return}}Pe.flags|=e,o.memoizedState=Oo(1|t,n,i,r)}function ud(e,t){return _i(8390656,8,e,t)}function ju(e,t){return Cs(2048,8,e,t)}function Ap(e,t){return Cs(4,2,e,t)}function Rp(e,t){return Cs(4,4,e,t)}function Np(e,t){if(typeof t=="function")return e=e(),t(e),function(){t(null)};if(t!=null)return e=e(),t.current=e,function(){t.current=null}}function Fp(e,t,n){return n=n!=null?n.concat([e]):null,Cs(4,4,Np.bind(null,t,e),n)}function Vu(){}function Lp(e,t){var n=$t();t=t===void 0?null:t;var r=n.memoizedState;return r!==null&&t!==null&&zu(t,r[1])?r[0]:(n.memoizedState=[e,t],e)}function Mp(e,t){var n=$t();t=t===void 0?null:t;var r=n.memoizedState;return r!==null&&t!==null&&zu(t,r[1])?r[0]:(e=e(),n.memoizedState=[e,t],e)}function Op(e,t,n){return(Kn&21)===0?(e.baseState&&(e.baseState=!1,lt=!0),e.memoizedState=n):(zt(n,t)||(n=Df(),Pe.lanes|=n,Xn|=n,e.baseState=!0),t)}function fg(e,t){var n=ge;ge=n!==0&&4>n?n:4,e(!0);var r=gl.transition;gl.transition={};try{e(!1),t()}finally{ge=n,gl.transition=r}}function zp(){return $t().memoizedState}function pg(e,t,n){var r=Tn(e);if(n={lane:r,action:n,hasEagerState:!1,eagerState:null,next:null},Ip(e))Dp(t,n);else if(n=mp(e,t,n,r),n!==null){var o=nt();Ot(n,e,r,o),jp(n,t,r)}}function hg(e,t,n){var r=Tn(e),o={lane:r,action:n,hasEagerState:!1,eagerState:null,next:null};if(Ip(e))Dp(t,o);else{var i=e.alternate;if(e.lanes===0&&(i===null||i.lanes===0)&&(i=t.lastRenderedReducer,i!==null))try{var s=t.lastRenderedState,l=i(s,n);if(o.hasEagerState=!0,o.eagerState=l,zt(l,s)){var a=t.interleaved;a===null?(o.next=o,Nu(t)):(o.next=a.next,a.next=o),t.interleaved=o;return}}catch{}finally{}n=mp(e,t,o,r),n!==null&&(o=nt(),Ot(n,e,r,o),jp(n,t,r))}}function Ip(e){var t=e.alternate;return e===Pe||t!==null&&t===Pe}function Dp(e,t){mo=Yi=!0;var n=e.pending;n===null?t.next=t:(t.next=n.next,n.next=t),e.pending=t}function jp(e,t,n){if((n&4194240)!==0){var r=t.lanes;r&=e.pendingLanes,n|=r,t.lanes=n,vu(e,n)}}var Gi={readContext:bt,useCallback:Ge,useContext:Ge,useEffect:Ge,useImperativeHandle:Ge,useInsertionEffect:Ge,useLayoutEffect:Ge,useMemo:Ge,useReducer:Ge,useRef:Ge,useState:Ge,useDebugValue:Ge,useDeferredValue:Ge,useTransition:Ge,useMutableSource:Ge,useSyncExternalStore:Ge,useId:Ge,unstable_isNewReconciler:!1},mg={readContext:bt,useCallback:function(e,t){return jt().memoizedState=[e,t===void 0?null:t],e},useContext:bt,useEffect:ud,useImperativeHandle:function(e,t,n){return n=n!=null?n.concat([e]):null,_i(4194308,4,Np.bind(null,t,e),n)},useLayoutEffect:function(e,t){return _i(4194308,4,e,t)},useInsertionEffect:function(e,t){return _i(4,2,e,t)},useMemo:function(e,t){var n=jt();return t=t===void 0?null:t,e=e(),n.memoizedState=[e,t],e},useReducer:function(e,t,n){var r=jt();return t=n!==void 0?n(t):t,r.memoizedState=r.baseState=t,e={pending:null,interleaved:null,lanes:0,dispatch:null,lastRenderedReducer:e,lastRenderedState:t},r.queue=e,e=e.dispatch=pg.bind(null,Pe,e),[r.memoizedState,e]},useRef:function(e){var t=jt();return e={current:e},t.memoizedState=e},useState:ad,useDebugValue:Vu,useDeferredValue:function(e){return jt().memoizedState=e},useTransition:function(){var e=ad(!1),t=e[0];return e=fg.bind(null,e[1]),jt().memoizedState=e,[t,e]},useMutableSource:function(){},useSyncExternalStore:function(e,t,n){var r=Pe,o=jt();if(Ee){if(n===void 0)throw Error(A(407));n=n()}else{if(n=t(),Ue===null)throw Error(A(349));(Kn&30)!==0||Cp(r,t,n)}o.memoizedState=n;var i={value:n,getSnapshot:t};return o.queue=i,ud(Tp.bind(null,r,i,e),[e]),r.flags|=2048,Oo(9,Ep.bind(null,r,i,n,t),void 0,null),n},useId:function(){var e=jt(),t=Ue.identifierPrefix;if(Ee){var n=Jt,r=qt;n=(r&~(1<<32-Mt(r)-1)).toString(32)+n,t=":"+t+"R"+n,n=Lo++,0<n&&(t+="H"+n.toString(32)),t+=":"}else n=dg++,t=":"+t+"r"+n.toString(32)+":";return e.memoizedState=t},unstable_isNewReconciler:!1},gg={readContext:bt,useCallback:Lp,useContext:bt,useEffect:ju,useImperativeHandle:Fp,useInsertionEffect:Ap,useLayoutEffect:Rp,useMemo:Mp,useReducer:yl,useRef:Pp,useState:function(){return yl(Mo)},useDebugValue:Vu,useDeferredValue:function(e){var t=$t();return Op(t,Ie.memoizedState,e)},useTransition:function(){var e=yl(Mo)[0],t=$t().memoizedState;return[e,t]},useMutableSource:Sp,useSyncExternalStore:_p,useId:zp,unstable_isNewReconciler:!1},yg={readContext:bt,useCallback:Lp,useContext:bt,useEffect:ju,useImperativeHandle:Fp,useInsertionEffect:Ap,useLayoutEffect:Rp,useMemo:Mp,useReducer:vl,useRef:Pp,useState:function(){return vl(Mo)},useDebugValue:Vu,useDeferredValue:function(e){var t=$t();return Ie===null?t.memoizedState=e:Op(t,Ie.memoizedState,e)},useTransition:function(){var e=vl(Mo)[0],t=$t().memoizedState;return[e,t]},useMutableSource:Sp,useSyncExternalStore:_p,useId:zp,unstable_isNewReconciler:!1};function zr(e,t){try{var n="",r=t;do n+=Hm(r),r=r.return;while(r);var o=n}catch(i){o=`
Error generating stack: `+i.message+`
`+i.stack}return{value:e,source:t,stack:o,digest:null}}function wl(e,t,n){return{value:e,source:null,stack:n!=null?n:null,digest:t!=null?t:null}}function fa(e,t){try{console.error(t.value)}catch(n){setTimeout(function(){throw n})}}var vg=typeof WeakMap=="function"?WeakMap:Map;function Vp(e,t,n){n=tn(-1,n),n.tag=3,n.payload={element:null};var r=t.value;return n.callback=function(){Xi||(Xi=!0,Sa=r),fa(e,t)},n}function Up(e,t,n){n=tn(-1,n),n.tag=3;var r=e.type.getDerivedStateFromError;if(typeof r=="function"){var o=t.value;n.payload=function(){return r(o)},n.callback=function(){fa(e,t)}}var i=e.stateNode;return i!==null&&typeof i.componentDidCatch=="function"&&(n.callback=function(){fa(e,t),typeof r!="function"&&(En===null?En=new Set([this]):En.add(this));var s=t.stack;this.componentDidCatch(t.value,{componentStack:s!==null?s:""})}),n}function cd(e,t,n){var r=e.pingCache;if(r===null){r=e.pingCache=new vg;var o=new Set;r.set(t,o)}else o=r.get(t),o===void 0&&(o=new Set,r.set(t,o));o.has(n)||(o.add(n),e=Ng.bind(null,e,t,n),t.then(e,e))}function dd(e){do{var t;if((t=e.tag===13)&&(t=e.memoizedState,t=t!==null?t.dehydrated!==null:!0),t)return e;e=e.return}while(e!==null);return null}function fd(e,t,n,r,o){return(e.mode&1)===0?(e===t?e.flags|=65536:(e.flags|=128,n.flags|=131072,n.flags&=-52805,n.tag===1&&(n.alternate===null?n.tag=17:(t=tn(-1,1),t.tag=2,Cn(n,t,1))),n.lanes|=1),e):(e.flags|=65536,e.lanes=o,e)}var wg=cn.ReactCurrentOwner,lt=!1;function et(e,t,n,r){t.child=e===null?xp(t,null,n,r):Mr(t,e.child,n,r)}function pd(e,t,n,r,o){n=n.render;var i=t.ref;return $r(t,o),r=Iu(e,t,n,r,i,o),n=Du(),e!==null&&!lt?(t.updateQueue=e.updateQueue,t.flags&=-2053,e.lanes&=~o,ln(e,t,o)):(Ee&&n&&Tu(t),t.flags|=1,et(e,t,r,o),t.child)}function hd(e,t,n,r,o){if(e===null){var i=n.type;return typeof i=="function"&&!Gu(i)&&i.defaultProps===void 0&&n.compare===null&&n.defaultProps===void 0?(t.tag=15,t.type=i,Bp(e,t,i,r,o)):(e=bi(n.type,null,r,t,t.mode,o),e.ref=t.ref,e.return=t,t.child=e)}if(i=e.child,(e.lanes&o)===0){var s=i.memoizedProps;if(n=n.compare,n=n!==null?n:$o,n(s,r)&&e.ref===t.ref)return ln(e,t,o)}return t.flags|=1,e=bn(i,r),e.ref=t.ref,e.return=t,t.child=e}function Bp(e,t,n,r,o){if(e!==null){var i=e.memoizedProps;if($o(i,r)&&e.ref===t.ref)if(lt=!1,t.pendingProps=r=i,(e.lanes&o)!==0)(e.flags&131072)!==0&&(lt=!0);else return t.lanes=e.lanes,ln(e,t,o)}return pa(e,t,n,r,o)}function Wp(e,t,n){var r=t.pendingProps,o=r.children,i=e!==null?e.memoizedState:null;if(r.mode==="hidden")if((t.mode&1)===0)t.memoizedState={baseLanes:0,cachePool:null,transitions:null},xe(wr,ht),ht|=n;else{if((n&1073741824)===0)return e=i!==null?i.baseLanes|n:n,t.lanes=t.childLanes=1073741824,t.memoizedState={baseLanes:e,cachePool:null,transitions:null},t.updateQueue=null,xe(wr,ht),ht|=e,null;t.memoizedState={baseLanes:0,cachePool:null,transitions:null},r=i!==null?i.baseLanes:n,xe(wr,ht),ht|=r}else i!==null?(r=i.baseLanes|n,t.memoizedState=null):r=n,xe(wr,ht),ht|=r;return et(e,t,o,n),t.child}function Hp(e,t){var n=t.ref;(e===null&&n!==null||e!==null&&e.ref!==n)&&(t.flags|=512,t.flags|=2097152)}function pa(e,t,n,r,o){var i=ut(n)?Yn:qe.current;return i=Fr(t,i),$r(t,o),n=Iu(e,t,n,r,i,o),r=Du(),e!==null&&!lt?(t.updateQueue=e.updateQueue,t.flags&=-2053,e.lanes&=~o,ln(e,t,o)):(Ee&&r&&Tu(t),t.flags|=1,et(e,t,n,o),t.child)}function md(e,t,n,r,o){if(ut(n)){var i=!0;Vi(t)}else i=!1;if($r(t,o),t.stateNode===null)Ci(e,t),vp(t,n,r),da(t,n,r,o),r=!0;else if(e===null){var s=t.stateNode,l=t.memoizedProps;s.props=l;var a=s.context,u=n.contextType;typeof u=="object"&&u!==null?u=bt(u):(u=ut(n)?Yn:qe.current,u=Fr(t,u));var c=n.getDerivedStateFromProps,d=typeof c=="function"||typeof s.getSnapshotBeforeUpdate=="function";d||typeof s.UNSAFE_componentWillReceiveProps!="function"&&typeof s.componentWillReceiveProps!="function"||(l!==r||a!==u)&&sd(t,s,r,u),mn=!1;var p=t.memoizedState;s.state=p,Zi(t,r,s,o),a=t.memoizedState,l!==r||p!==a||at.current||mn?(typeof c=="function"&&(ca(t,n,c,r),a=t.memoizedState),(l=mn||id(t,n,l,r,p,a,u))?(d||typeof s.UNSAFE_componentWillMount!="function"&&typeof s.componentWillMount!="function"||(typeof s.componentWillMount=="function"&&s.componentWillMount(),typeof s.UNSAFE_componentWillMount=="function"&&s.UNSAFE_componentWillMount()),typeof s.componentDidMount=="function"&&(t.flags|=4194308)):(typeof s.componentDidMount=="function"&&(t.flags|=4194308),t.memoizedProps=r,t.memoizedState=a),s.props=r,s.state=a,s.context=u,r=l):(typeof s.componentDidMount=="function"&&(t.flags|=4194308),r=!1)}else{s=t.stateNode,gp(e,t),l=t.memoizedProps,u=t.type===t.elementType?l:Rt(t.type,l),s.props=u,d=t.pendingProps,p=s.context,a=n.contextType,typeof a=="object"&&a!==null?a=bt(a):(a=ut(n)?Yn:qe.current,a=Fr(t,a));var C=n.getDerivedStateFromProps;(c=typeof C=="function"||typeof s.getSnapshotBeforeUpdate=="function")||typeof s.UNSAFE_componentWillReceiveProps!="function"&&typeof s.componentWillReceiveProps!="function"||(l!==d||p!==a)&&sd(t,s,r,a),mn=!1,p=t.memoizedState,s.state=p,Zi(t,r,s,o);var S=t.memoizedState;l!==d||p!==S||at.current||mn?(typeof C=="function"&&(ca(t,n,C,r),S=t.memoizedState),(u=mn||id(t,n,u,r,p,S,a)||!1)?(c||typeof s.UNSAFE_componentWillUpdate!="function"&&typeof s.componentWillUpdate!="function"||(typeof s.componentWillUpdate=="function"&&s.componentWillUpdate(r,S,a),typeof s.UNSAFE_componentWillUpdate=="function"&&s.UNSAFE_componentWillUpdate(r,S,a)),typeof s.componentDidUpdate=="function"&&(t.flags|=4),typeof s.getSnapshotBeforeUpdate=="function"&&(t.flags|=1024)):(typeof s.componentDidUpdate!="function"||l===e.memoizedProps&&p===e.memoizedState||(t.flags|=4),typeof s.getSnapshotBeforeUpdate!="function"||l===e.memoizedProps&&p===e.memoizedState||(t.flags|=1024),t.memoizedProps=r,t.memoizedState=S),s.props=r,s.state=S,s.context=a,r=u):(typeof s.componentDidUpdate!="function"||l===e.memoizedProps&&p===e.memoizedState||(t.flags|=4),typeof s.getSnapshotBeforeUpdate!="function"||l===e.memoizedProps&&p===e.memoizedState||(t.flags|=1024),r=!1)}return ha(e,t,n,r,i,o)}function ha(e,t,n,r,o,i){Hp(e,t);var s=(t.flags&128)!==0;if(!r&&!s)return o&&ed(t,n,!1),ln(e,t,i);r=t.stateNode,wg.current=t;var l=s&&typeof n.getDerivedStateFromError!="function"?null:r.render();return t.flags|=1,e!==null&&s?(t.child=Mr(t,e.child,null,i),t.child=Mr(t,null,l,i)):et(e,t,l,i),t.memoizedState=r.state,o&&ed(t,n,!0),t.child}function Zp(e){var t=e.stateNode;t.pendingContext?Jc(e,t.pendingContext,t.pendingContext!==t.context):t.context&&Jc(e,t.context,!1),Lu(e,t.containerInfo)}function gd(e,t,n,r,o){return Lr(),$u(o),t.flags|=256,et(e,t,n,r),t.child}var ma={dehydrated:null,treeContext:null,retryLane:0};function ga(e){return{baseLanes:e,cachePool:null,transitions:null}}function Qp(e,t,n){var r=t.pendingProps,o=$e.current,i=!1,s=(t.flags&128)!==0,l;if((l=s)||(l=e!==null&&e.memoizedState===null?!1:(o&2)!==0),l?(i=!0,t.flags&=-129):(e===null||e.memoizedState!==null)&&(o|=1),xe($e,o&1),e===null)return aa(t),e=t.memoizedState,e!==null&&(e=e.dehydrated,e!==null)?((t.mode&1)===0?t.lanes=1:e.data==="$!"?t.lanes=8:t.lanes=1073741824,null):(s=r.children,e=r.fallback,i?(r=t.mode,i=t.child,s={mode:"hidden",children:s},(r&1)===0&&i!==null?(i.childLanes=0,i.pendingProps=s):i=bs(s,r,0,null),e=Qn(e,r,n,null),i.return=t,e.return=t,i.sibling=e,t.child=i,t.child.memoizedState=ga(n),t.memoizedState=ma,e):Uu(t,s));if(o=e.memoizedState,o!==null&&(l=o.dehydrated,l!==null))return xg(e,t,s,r,l,o,n);if(i){i=r.fallback,s=t.mode,o=e.child,l=o.sibling;var a={mode:"hidden",children:r.children};return(s&1)===0&&t.child!==o?(r=t.child,r.childLanes=0,r.pendingProps=a,t.deletions=null):(r=bn(o,a),r.subtreeFlags=o.subtreeFlags&14680064),l!==null?i=bn(l,i):(i=Qn(i,s,n,null),i.flags|=2),i.return=t,r.return=t,r.sibling=i,t.child=r,r=i,i=t.child,s=e.child.memoizedState,s=s===null?ga(n):{baseLanes:s.baseLanes|n,cachePool:null,transitions:s.transitions},i.memoizedState=s,i.childLanes=e.childLanes&~n,t.memoizedState=ma,r}return i=e.child,e=i.sibling,r=bn(i,{mode:"visible",children:r.children}),(t.mode&1)===0&&(r.lanes=n),r.return=t,r.sibling=null,e!==null&&(n=t.deletions,n===null?(t.deletions=[e],t.flags|=16):n.push(e)),t.child=r,t.memoizedState=null,r}function Uu(e,t){return t=bs({mode:"visible",children:t},e.mode,0,null),t.return=e,e.child=t}function ui(e,t,n,r){return r!==null&&$u(r),Mr(t,e.child,null,n),e=Uu(t,t.pendingProps.children),e.flags|=2,t.memoizedState=null,e}function xg(e,t,n,r,o,i,s){if(n)return t.flags&256?(t.flags&=-257,r=wl(Error(A(422))),ui(e,t,s,r)):t.memoizedState!==null?(t.child=e.child,t.flags|=128,null):(i=r.fallback,o=t.mode,r=bs({mode:"visible",children:r.children},o,0,null),i=Qn(i,o,s,null),i.flags|=2,r.return=t,i.return=t,r.sibling=i,t.child=r,(t.mode&1)!==0&&Mr(t,e.child,null,s),t.child.memoizedState=ga(s),t.memoizedState=ma,i);if((t.mode&1)===0)return ui(e,t,s,null);if(o.data==="$!"){if(r=o.nextSibling&&o.nextSibling.dataset,r)var l=r.dgst;return r=l,i=Error(A(419)),r=wl(i,r,void 0),ui(e,t,s,r)}if(l=(s&e.childLanes)!==0,lt||l){if(r=Ue,r!==null){switch(s&-s){case 4:o=2;break;case 16:o=8;break;case 64:case 128:case 256:case 512:case 1024:case 2048:case 4096:case 8192:case 16384:case 32768:case 65536:case 131072:case 262144:case 524288:case 1048576:case 2097152:case 4194304:case 8388608:case 16777216:case 33554432:case 67108864:o=32;break;case 536870912:o=268435456;break;default:o=0}o=(o&(r.suspendedLanes|s))!==0?0:o,o!==0&&o!==i.retryLane&&(i.retryLane=o,sn(e,o),Ot(r,e,o,-1))}return Yu(),r=wl(Error(A(421))),ui(e,t,s,r)}return o.data==="$?"?(t.flags|=128,t.child=e.child,t=Fg.bind(null,e),o._reactRetry=t,null):(e=i.treeContext,mt=_n(o.nextSibling),gt=t,Ee=!0,Ft=null,e!==null&&(_t[Ct++]=qt,_t[Ct++]=Jt,_t[Ct++]=Gn,qt=e.id,Jt=e.overflow,Gn=t),t=Uu(t,r.children),t.flags|=4096,t)}function yd(e,t,n){e.lanes|=t;var r=e.alternate;r!==null&&(r.lanes|=t),ua(e.return,t,n)}function xl(e,t,n,r,o){var i=e.memoizedState;i===null?e.memoizedState={isBackwards:t,rendering:null,renderingStartTime:0,last:r,tail:n,tailMode:o}:(i.isBackwards=t,i.rendering=null,i.renderingStartTime=0,i.last=r,i.tail=n,i.tailMode=o)}function Yp(e,t,n){var r=t.pendingProps,o=r.revealOrder,i=r.tail;if(et(e,t,r.children,n),r=$e.current,(r&2)!==0)r=r&1|2,t.flags|=128;else{if(e!==null&&(e.flags&128)!==0)e:for(e=t.child;e!==null;){if(e.tag===13)e.memoizedState!==null&&yd(e,n,t);else if(e.tag===19)yd(e,n,t);else if(e.child!==null){e.child.return=e,e=e.child;continue}if(e===t)break e;for(;e.sibling===null;){if(e.return===null||e.return===t)break e;e=e.return}e.sibling.return=e.return,e=e.sibling}r&=1}if(xe($e,r),(t.mode&1)===0)t.memoizedState=null;else switch(o){case"forwards":for(n=t.child,o=null;n!==null;)e=n.alternate,e!==null&&Qi(e)===null&&(o=n),n=n.sibling;n=o,n===null?(o=t.child,t.child=null):(o=n.sibling,n.sibling=null),xl(t,!1,o,n,i);break;case"backwards":for(n=null,o=t.child,t.child=null;o!==null;){if(e=o.alternate,e!==null&&Qi(e)===null){t.child=o;break}e=o.sibling,o.sibling=n,n=o,o=e}xl(t,!0,n,null,i);break;case"together":xl(t,!1,null,null,void 0);break;default:t.memoizedState=null}return t.child}function Ci(e,t){(t.mode&1)===0&&e!==null&&(e.alternate=null,t.alternate=null,t.flags|=2)}function ln(e,t,n){if(e!==null&&(t.dependencies=e.dependencies),Xn|=t.lanes,(n&t.childLanes)===0)return null;if(e!==null&&t.child!==e.child)throw Error(A(153));if(t.child!==null){for(e=t.child,n=bn(e,e.pendingProps),t.child=n,n.return=t;e.sibling!==null;)e=e.sibling,n=n.sibling=bn(e,e.pendingProps),n.return=t;n.sibling=null}return t.child}function kg(e,t,n){switch(t.tag){case 3:Zp(t),Lr();break;case 5:kp(t);break;case 1:ut(t.type)&&Vi(t);break;case 4:Lu(t,t.stateNode.containerInfo);break;case 10:var r=t.type._context,o=t.memoizedProps.value;xe(Wi,r._currentValue),r._currentValue=o;break;case 13:if(r=t.memoizedState,r!==null)return r.dehydrated!==null?(xe($e,$e.current&1),t.flags|=128,null):(n&t.child.childLanes)!==0?Qp(e,t,n):(xe($e,$e.current&1),e=ln(e,t,n),e!==null?e.sibling:null);xe($e,$e.current&1);break;case 19:if(r=(n&t.childLanes)!==0,(e.flags&128)!==0){if(r)return Yp(e,t,n);t.flags|=128}if(o=t.memoizedState,o!==null&&(o.rendering=null,o.tail=null,o.lastEffect=null),xe($e,$e.current),r)break;return null;case 22:case 23:return t.lanes=0,Wp(e,t,n)}return ln(e,t,n)}var Gp,ya,Kp,Xp;Gp=function(e,t){for(var n=t.child;n!==null;){if(n.tag===5||n.tag===6)e.appendChild(n.stateNode);else if(n.tag!==4&&n.child!==null){n.child.return=n,n=n.child;continue}if(n===t)break;for(;n.sibling===null;){if(n.return===null||n.return===t)return;n=n.return}n.sibling.return=n.return,n=n.sibling}};ya=function(){};Kp=function(e,t,n,r){var o=e.memoizedProps;if(o!==r){e=t.stateNode,Hn(Zt.current);var i=null;switch(n){case"input":o=Dl(e,o),r=Dl(e,r),i=[];break;case"select":o=Ae({},o,{value:void 0}),r=Ae({},r,{value:void 0}),i=[];break;case"textarea":o=Ul(e,o),r=Ul(e,r),i=[];break;default:typeof o.onClick!="function"&&typeof r.onClick=="function"&&(e.onclick=Di)}Wl(n,r);var s;n=null;for(u in o)if(!r.hasOwnProperty(u)&&o.hasOwnProperty(u)&&o[u]!=null)if(u==="style"){var l=o[u];for(s in l)l.hasOwnProperty(s)&&(n||(n={}),n[s]="")}else u!=="dangerouslySetInnerHTML"&&u!=="children"&&u!=="suppressContentEditableWarning"&&u!=="suppressHydrationWarning"&&u!=="autoFocus"&&(ko.hasOwnProperty(u)?i||(i=[]):(i=i||[]).push(u,null));for(u in r){var a=r[u];if(l=o!=null?o[u]:void 0,r.hasOwnProperty(u)&&a!==l&&(a!=null||l!=null))if(u==="style")if(l){for(s in l)!l.hasOwnProperty(s)||a&&a.hasOwnProperty(s)||(n||(n={}),n[s]="");for(s in a)a.hasOwnProperty(s)&&l[s]!==a[s]&&(n||(n={}),n[s]=a[s])}else n||(i||(i=[]),i.push(u,n)),n=a;else u==="dangerouslySetInnerHTML"?(a=a?a.__html:void 0,l=l?l.__html:void 0,a!=null&&l!==a&&(i=i||[]).push(u,a)):u==="children"?typeof a!="string"&&typeof a!="number"||(i=i||[]).push(u,""+a):u!=="suppressContentEditableWarning"&&u!=="suppressHydrationWarning"&&(ko.hasOwnProperty(u)?(a!=null&&u==="onScroll"&&ke("scroll",e),i||l===a||(i=[])):(i=i||[]).push(u,a))}n&&(i=i||[]).push("style",n);var u=i;(t.updateQueue=u)&&(t.flags|=4)}};Xp=function(e,t,n,r){n!==r&&(t.flags|=4)};function to(e,t){if(!Ee)switch(e.tailMode){case"hidden":t=e.tail;for(var n=null;t!==null;)t.alternate!==null&&(n=t),t=t.sibling;n===null?e.tail=null:n.sibling=null;break;case"collapsed":n=e.tail;for(var r=null;n!==null;)n.alternate!==null&&(r=n),n=n.sibling;r===null?t||e.tail===null?e.tail=null:e.tail.sibling=null:r.sibling=null}}function Ke(e){var t=e.alternate!==null&&e.alternate.child===e.child,n=0,r=0;if(t)for(var o=e.child;o!==null;)n|=o.lanes|o.childLanes,r|=o.subtreeFlags&14680064,r|=o.flags&14680064,o.return=e,o=o.sibling;else for(o=e.child;o!==null;)n|=o.lanes|o.childLanes,r|=o.subtreeFlags,r|=o.flags,o.return=e,o=o.sibling;return e.subtreeFlags|=r,e.childLanes=n,t}function Sg(e,t,n){var r=t.pendingProps;switch(bu(t),t.tag){case 2:case 16:case 15:case 0:case 11:case 7:case 8:case 12:case 9:case 14:return Ke(t),null;case 1:return ut(t.type)&&ji(),Ke(t),null;case 3:return r=t.stateNode,Or(),_e(at),_e(qe),Ou(),r.pendingContext&&(r.context=r.pendingContext,r.pendingContext=null),(e===null||e.child===null)&&(li(t)?t.flags|=4:e===null||e.memoizedState.isDehydrated&&(t.flags&256)===0||(t.flags|=1024,Ft!==null&&(Ea(Ft),Ft=null))),ya(e,t),Ke(t),null;case 5:Mu(t);var o=Hn(Fo.current);if(n=t.type,e!==null&&t.stateNode!=null)Kp(e,t,n,r,o),e.ref!==t.ref&&(t.flags|=512,t.flags|=2097152);else{if(!r){if(t.stateNode===null)throw Error(A(166));return Ke(t),null}if(e=Hn(Zt.current),li(t)){r=t.stateNode,n=t.type;var i=t.memoizedProps;switch(r[Ut]=t,r[Ro]=i,e=(t.mode&1)!==0,n){case"dialog":ke("cancel",r),ke("close",r);break;case"iframe":case"object":case"embed":ke("load",r);break;case"video":case"audio":for(o=0;o<lo.length;o++)ke(lo[o],r);break;case"source":ke("error",r);break;case"img":case"image":case"link":ke("error",r),ke("load",r);break;case"details":ke("toggle",r);break;case"input":Tc(r,i),ke("invalid",r);break;case"select":r._wrapperState={wasMultiple:!!i.multiple},ke("invalid",r);break;case"textarea":$c(r,i),ke("invalid",r)}Wl(n,i),o=null;for(var s in i)if(i.hasOwnProperty(s)){var l=i[s];s==="children"?typeof l=="string"?r.textContent!==l&&(i.suppressHydrationWarning!==!0&&si(r.textContent,l,e),o=["children",l]):typeof l=="number"&&r.textContent!==""+l&&(i.suppressHydrationWarning!==!0&&si(r.textContent,l,e),o=["children",""+l]):ko.hasOwnProperty(s)&&l!=null&&s==="onScroll"&&ke("scroll",r)}switch(n){case"input":qo(r),bc(r,i,!0);break;case"textarea":qo(r),Pc(r);break;case"select":case"option":break;default:typeof i.onClick=="function"&&(r.onclick=Di)}r=o,t.updateQueue=r,r!==null&&(t.flags|=4)}else{s=o.nodeType===9?o:o.ownerDocument,e==="http://www.w3.org/1999/xhtml"&&(e=Cf(n)),e==="http://www.w3.org/1999/xhtml"?n==="script"?(e=s.createElement("div"),e.innerHTML="<script><\/script>",e=e.removeChild(e.firstChild)):typeof r.is=="string"?e=s.createElement(n,{is:r.is}):(e=s.createElement(n),n==="select"&&(s=e,r.multiple?s.multiple=!0:r.size&&(s.size=r.size))):e=s.createElementNS(e,n),e[Ut]=t,e[Ro]=r,Gp(e,t,!1,!1),t.stateNode=e;e:{switch(s=Hl(n,r),n){case"dialog":ke("cancel",e),ke("close",e),o=r;break;case"iframe":case"object":case"embed":ke("load",e),o=r;break;case"video":case"audio":for(o=0;o<lo.length;o++)ke(lo[o],e);o=r;break;case"source":ke("error",e),o=r;break;case"img":case"image":case"link":ke("error",e),ke("load",e),o=r;break;case"details":ke("toggle",e),o=r;break;case"input":Tc(e,r),o=Dl(e,r),ke("invalid",e);break;case"option":o=r;break;case"select":e._wrapperState={wasMultiple:!!r.multiple},o=Ae({},r,{value:void 0}),ke("invalid",e);break;case"textarea":$c(e,r),o=Ul(e,r),ke("invalid",e);break;default:o=r}Wl(n,o),l=o;for(i in l)if(l.hasOwnProperty(i)){var a=l[i];i==="style"?bf(e,a):i==="dangerouslySetInnerHTML"?(a=a?a.__html:void 0,a!=null&&Ef(e,a)):i==="children"?typeof a=="string"?(n!=="textarea"||a!=="")&&So(e,a):typeof a=="number"&&So(e,""+a):i!=="suppressContentEditableWarning"&&i!=="suppressHydrationWarning"&&i!=="autoFocus"&&(ko.hasOwnProperty(i)?a!=null&&i==="onScroll"&&ke("scroll",e):a!=null&&fu(e,i,a,s))}switch(n){case"input":qo(e),bc(e,r,!1);break;case"textarea":qo(e),Pc(e);break;case"option":r.value!=null&&e.setAttribute("value",""+An(r.value));break;case"select":e.multiple=!!r.multiple,i=r.value,i!=null?Cr(e,!!r.multiple,i,!1):r.defaultValue!=null&&Cr(e,!!r.multiple,r.defaultValue,!0);break;default:typeof o.onClick=="function"&&(e.onclick=Di)}switch(n){case"button":case"input":case"select":case"textarea":r=!!r.autoFocus;break e;case"img":r=!0;break e;default:r=!1}}r&&(t.flags|=4)}t.ref!==null&&(t.flags|=512,t.flags|=2097152)}return Ke(t),null;case 6:if(e&&t.stateNode!=null)Xp(e,t,e.memoizedProps,r);else{if(typeof r!="string"&&t.stateNode===null)throw Error(A(166));if(n=Hn(Fo.current),Hn(Zt.current),li(t)){if(r=t.stateNode,n=t.memoizedProps,r[Ut]=t,(i=r.nodeValue!==n)&&(e=gt,e!==null))switch(e.tag){case 3:si(r.nodeValue,n,(e.mode&1)!==0);break;case 5:e.memoizedProps.suppressHydrationWarning!==!0&&si(r.nodeValue,n,(e.mode&1)!==0)}i&&(t.flags|=4)}else r=(n.nodeType===9?n:n.ownerDocument).createTextNode(r),r[Ut]=t,t.stateNode=r}return Ke(t),null;case 13:if(_e($e),r=t.memoizedState,e===null||e.memoizedState!==null&&e.memoizedState.dehydrated!==null){if(Ee&&mt!==null&&(t.mode&1)!==0&&(t.flags&128)===0)hp(),Lr(),t.flags|=98560,i=!1;else if(i=li(t),r!==null&&r.dehydrated!==null){if(e===null){if(!i)throw Error(A(318));if(i=t.memoizedState,i=i!==null?i.dehydrated:null,!i)throw Error(A(317));i[Ut]=t}else Lr(),(t.flags&128)===0&&(t.memoizedState=null),t.flags|=4;Ke(t),i=!1}else Ft!==null&&(Ea(Ft),Ft=null),i=!0;if(!i)return t.flags&65536?t:null}return(t.flags&128)!==0?(t.lanes=n,t):(r=r!==null,r!==(e!==null&&e.memoizedState!==null)&&r&&(t.child.flags|=8192,(t.mode&1)!==0&&(e===null||($e.current&1)!==0?De===0&&(De=3):Yu())),t.updateQueue!==null&&(t.flags|=4),Ke(t),null);case 4:return Or(),ya(e,t),e===null&&Po(t.stateNode.containerInfo),Ke(t),null;case 10:return Ru(t.type._context),Ke(t),null;case 17:return ut(t.type)&&ji(),Ke(t),null;case 19:if(_e($e),i=t.memoizedState,i===null)return Ke(t),null;if(r=(t.flags&128)!==0,s=i.rendering,s===null)if(r)to(i,!1);else{if(De!==0||e!==null&&(e.flags&128)!==0)for(e=t.child;e!==null;){if(s=Qi(e),s!==null){for(t.flags|=128,to(i,!1),r=s.updateQueue,r!==null&&(t.updateQueue=r,t.flags|=4),t.subtreeFlags=0,r=n,n=t.child;n!==null;)i=n,e=r,i.flags&=14680066,s=i.alternate,s===null?(i.childLanes=0,i.lanes=e,i.child=null,i.subtreeFlags=0,i.memoizedProps=null,i.memoizedState=null,i.updateQueue=null,i.dependencies=null,i.stateNode=null):(i.childLanes=s.childLanes,i.lanes=s.lanes,i.child=s.child,i.subtreeFlags=0,i.deletions=null,i.memoizedProps=s.memoizedProps,i.memoizedState=s.memoizedState,i.updateQueue=s.updateQueue,i.type=s.type,e=s.dependencies,i.dependencies=e===null?null:{lanes:e.lanes,firstContext:e.firstContext}),n=n.sibling;return xe($e,$e.current&1|2),t.child}e=e.sibling}i.tail!==null&&Me()>Ir&&(t.flags|=128,r=!0,to(i,!1),t.lanes=4194304)}else{if(!r)if(e=Qi(s),e!==null){if(t.flags|=128,r=!0,n=e.updateQueue,n!==null&&(t.updateQueue=n,t.flags|=4),to(i,!0),i.tail===null&&i.tailMode==="hidden"&&!s.alternate&&!Ee)return Ke(t),null}else 2*Me()-i.renderingStartTime>Ir&&n!==1073741824&&(t.flags|=128,r=!0,to(i,!1),t.lanes=4194304);i.isBackwards?(s.sibling=t.child,t.child=s):(n=i.last,n!==null?n.sibling=s:t.child=s,i.last=s)}return i.tail!==null?(t=i.tail,i.rendering=t,i.tail=t.sibling,i.renderingStartTime=Me(),t.sibling=null,n=$e.current,xe($e,r?n&1|2:n&1),t):(Ke(t),null);case 22:case 23:return Qu(),r=t.memoizedState!==null,e!==null&&e.memoizedState!==null!==r&&(t.flags|=8192),r&&(t.mode&1)!==0?(ht&1073741824)!==0&&(Ke(t),t.subtreeFlags&6&&(t.flags|=8192)):Ke(t),null;case 24:return null;case 25:return null}throw Error(A(156,t.tag))}function _g(e,t){switch(bu(t),t.tag){case 1:return ut(t.type)&&ji(),e=t.flags,e&65536?(t.flags=e&-65537|128,t):null;case 3:return Or(),_e(at),_e(qe),Ou(),e=t.flags,(e&65536)!==0&&(e&128)===0?(t.flags=e&-65537|128,t):null;case 5:return Mu(t),null;case 13:if(_e($e),e=t.memoizedState,e!==null&&e.dehydrated!==null){if(t.alternate===null)throw Error(A(340));Lr()}return e=t.flags,e&65536?(t.flags=e&-65537|128,t):null;case 19:return _e($e),null;case 4:return Or(),null;case 10:return Ru(t.type._context),null;case 22:case 23:return Qu(),null;case 24:return null;default:return null}}var ci=!1,Xe=!1,Cg=typeof WeakSet=="function"?WeakSet:Set,W=null;function vr(e,t){var n=e.ref;if(n!==null)if(typeof n=="function")try{n(null)}catch(r){Ne(e,t,r)}else n.current=null}function va(e,t,n){try{n()}catch(r){Ne(e,t,r)}}var vd=!1;function Eg(e,t){if(ta=Oi,e=tp(),Eu(e)){if("selectionStart"in e)var n={start:e.selectionStart,end:e.selectionEnd};else e:{n=(n=e.ownerDocument)&&n.defaultView||window;var r=n.getSelection&&n.getSelection();if(r&&r.rangeCount!==0){n=r.anchorNode;var o=r.anchorOffset,i=r.focusNode;r=r.focusOffset;try{n.nodeType,i.nodeType}catch{n=null;break e}var s=0,l=-1,a=-1,u=0,c=0,d=e,p=null;t:for(;;){for(var C;d!==n||o!==0&&d.nodeType!==3||(l=s+o),d!==i||r!==0&&d.nodeType!==3||(a=s+r),d.nodeType===3&&(s+=d.nodeValue.length),(C=d.firstChild)!==null;)p=d,d=C;for(;;){if(d===e)break t;if(p===n&&++u===o&&(l=s),p===i&&++c===r&&(a=s),(C=d.nextSibling)!==null)break;d=p,p=d.parentNode}d=C}n=l===-1||a===-1?null:{start:l,end:a}}else n=null}n=n||{start:0,end:0}}else n=null;for(na={focusedElem:e,selectionRange:n},Oi=!1,W=t;W!==null;)if(t=W,e=t.child,(t.subtreeFlags&1028)!==0&&e!==null)e.return=t,W=e;else for(;W!==null;){t=W;try{var S=t.alternate;if((t.flags&1024)!==0)switch(t.tag){case 0:case 11:case 15:break;case 1:if(S!==null){var E=S.memoizedProps,M=S.memoizedState,h=t.stateNode,f=h.getSnapshotBeforeUpdate(t.elementType===t.type?E:Rt(t.type,E),M);h.__reactInternalSnapshotBeforeUpdate=f}break;case 3:var g=t.stateNode.containerInfo;g.nodeType===1?g.textContent="":g.nodeType===9&&g.documentElement&&g.removeChild(g.documentElement);break;case 5:case 6:case 4:case 17:break;default:throw Error(A(163))}}catch(x){Ne(t,t.return,x)}if(e=t.sibling,e!==null){e.return=t.return,W=e;break}W=t.return}return S=vd,vd=!1,S}function go(e,t,n){var r=t.updateQueue;if(r=r!==null?r.lastEffect:null,r!==null){var o=r=r.next;do{if((o.tag&e)===e){var i=o.destroy;o.destroy=void 0,i!==void 0&&va(t,n,i)}o=o.next}while(o!==r)}}function Es(e,t){if(t=t.updateQueue,t=t!==null?t.lastEffect:null,t!==null){var n=t=t.next;do{if((n.tag&e)===e){var r=n.create;n.destroy=r()}n=n.next}while(n!==t)}}function wa(e){var t=e.ref;if(t!==null){var n=e.stateNode;switch(e.tag){case 5:e=n;break;default:e=n}typeof t=="function"?t(e):t.current=e}}function qp(e){var t=e.alternate;t!==null&&(e.alternate=null,qp(t)),e.child=null,e.deletions=null,e.sibling=null,e.tag===5&&(t=e.stateNode,t!==null&&(delete t[Ut],delete t[Ro],delete t[ia],delete t[lg],delete t[ag])),e.stateNode=null,e.return=null,e.dependencies=null,e.memoizedProps=null,e.memoizedState=null,e.pendingProps=null,e.stateNode=null,e.updateQueue=null}function Jp(e){return e.tag===5||e.tag===3||e.tag===4}function wd(e){e:for(;;){for(;e.sibling===null;){if(e.return===null||Jp(e.return))return null;e=e.return}for(e.sibling.return=e.return,e=e.sibling;e.tag!==5&&e.tag!==6&&e.tag!==18;){if(e.flags&2||e.child===null||e.tag===4)continue e;e.child.return=e,e=e.child}if(!(e.flags&2))return e.stateNode}}function xa(e,t,n){var r=e.tag;if(r===5||r===6)e=e.stateNode,t?n.nodeType===8?n.parentNode.insertBefore(e,t):n.insertBefore(e,t):(n.nodeType===8?(t=n.parentNode,t.insertBefore(e,n)):(t=n,t.appendChild(e)),n=n._reactRootContainer,n!=null||t.onclick!==null||(t.onclick=Di));else if(r!==4&&(e=e.child,e!==null))for(xa(e,t,n),e=e.sibling;e!==null;)xa(e,t,n),e=e.sibling}function ka(e,t,n){var r=e.tag;if(r===5||r===6)e=e.stateNode,t?n.insertBefore(e,t):n.appendChild(e);else if(r!==4&&(e=e.child,e!==null))for(ka(e,t,n),e=e.sibling;e!==null;)ka(e,t,n),e=e.sibling}var Ze=null,Nt=!1;function pn(e,t,n){for(n=n.child;n!==null;)eh(e,t,n),n=n.sibling}function eh(e,t,n){if(Ht&&typeof Ht.onCommitFiberUnmount=="function")try{Ht.onCommitFiberUnmount(ys,n)}catch{}switch(n.tag){case 5:Xe||vr(n,t);case 6:var r=Ze,o=Nt;Ze=null,pn(e,t,n),Ze=r,Nt=o,Ze!==null&&(Nt?(e=Ze,n=n.stateNode,e.nodeType===8?e.parentNode.removeChild(n):e.removeChild(n)):Ze.removeChild(n.stateNode));break;case 18:Ze!==null&&(Nt?(e=Ze,n=n.stateNode,e.nodeType===8?pl(e.parentNode,n):e.nodeType===1&&pl(e,n),To(e)):pl(Ze,n.stateNode));break;case 4:r=Ze,o=Nt,Ze=n.stateNode.containerInfo,Nt=!0,pn(e,t,n),Ze=r,Nt=o;break;case 0:case 11:case 14:case 15:if(!Xe&&(r=n.updateQueue,r!==null&&(r=r.lastEffect,r!==null))){o=r=r.next;do{var i=o,s=i.destroy;i=i.tag,s!==void 0&&((i&2)!==0||(i&4)!==0)&&va(n,t,s),o=o.next}while(o!==r)}pn(e,t,n);break;case 1:if(!Xe&&(vr(n,t),r=n.stateNode,typeof r.componentWillUnmount=="function"))try{r.props=n.memoizedProps,r.state=n.memoizedState,r.componentWillUnmount()}catch(l){Ne(n,t,l)}pn(e,t,n);break;case 21:pn(e,t,n);break;case 22:n.mode&1?(Xe=(r=Xe)||n.memoizedState!==null,pn(e,t,n),Xe=r):pn(e,t,n);break;default:pn(e,t,n)}}function xd(e){var t=e.updateQueue;if(t!==null){e.updateQueue=null;var n=e.stateNode;n===null&&(n=e.stateNode=new Cg),t.forEach(function(r){var o=Lg.bind(null,e,r);n.has(r)||(n.add(r),r.then(o,o))})}}function At(e,t){var n=t.deletions;if(n!==null)for(var r=0;r<n.length;r++){var o=n[r];try{var i=e,s=t,l=s;e:for(;l!==null;){switch(l.tag){case 5:Ze=l.stateNode,Nt=!1;break e;case 3:Ze=l.stateNode.containerInfo,Nt=!0;break e;case 4:Ze=l.stateNode.containerInfo,Nt=!0;break e}l=l.return}if(Ze===null)throw Error(A(160));eh(i,s,o),Ze=null,Nt=!1;var a=o.alternate;a!==null&&(a.return=null),o.return=null}catch(u){Ne(o,t,u)}}if(t.subtreeFlags&12854)for(t=t.child;t!==null;)th(t,e),t=t.sibling}function th(e,t){var n=e.alternate,r=e.flags;switch(e.tag){case 0:case 11:case 14:case 15:if(At(t,e),Dt(e),r&4){try{go(3,e,e.return),Es(3,e)}catch(E){Ne(e,e.return,E)}try{go(5,e,e.return)}catch(E){Ne(e,e.return,E)}}break;case 1:At(t,e),Dt(e),r&512&&n!==null&&vr(n,n.return);break;case 5:if(At(t,e),Dt(e),r&512&&n!==null&&vr(n,n.return),e.flags&32){var o=e.stateNode;try{So(o,"")}catch(E){Ne(e,e.return,E)}}if(r&4&&(o=e.stateNode,o!=null)){var i=e.memoizedProps,s=n!==null?n.memoizedProps:i,l=e.type,a=e.updateQueue;if(e.updateQueue=null,a!==null)try{l==="input"&&i.type==="radio"&&i.name!=null&&Sf(o,i),Hl(l,s);var u=Hl(l,i);for(s=0;s<a.length;s+=2){var c=a[s],d=a[s+1];c==="style"?bf(o,d):c==="dangerouslySetInnerHTML"?Ef(o,d):c==="children"?So(o,d):fu(o,c,d,u)}switch(l){case"input":jl(o,i);break;case"textarea":_f(o,i);break;case"select":var p=o._wrapperState.wasMultiple;o._wrapperState.wasMultiple=!!i.multiple;var C=i.value;C!=null?Cr(o,!!i.multiple,C,!1):p!==!!i.multiple&&(i.defaultValue!=null?Cr(o,!!i.multiple,i.defaultValue,!0):Cr(o,!!i.multiple,i.multiple?[]:"",!1))}o[Ro]=i}catch(E){Ne(e,e.return,E)}}break;case 6:if(At(t,e),Dt(e),r&4){if(e.stateNode===null)throw Error(A(162));o=e.stateNode,i=e.memoizedProps;try{o.nodeValue=i}catch(E){Ne(e,e.return,E)}}break;case 3:if(At(t,e),Dt(e),r&4&&n!==null&&n.memoizedState.isDehydrated)try{To(t.containerInfo)}catch(E){Ne(e,e.return,E)}break;case 4:At(t,e),Dt(e);break;case 13:At(t,e),Dt(e),o=e.child,o.flags&8192&&(i=o.memoizedState!==null,o.stateNode.isHidden=i,!i||o.alternate!==null&&o.alternate.memoizedState!==null||(Hu=Me())),r&4&&xd(e);break;case 22:if(c=n!==null&&n.memoizedState!==null,e.mode&1?(Xe=(u=Xe)||c,At(t,e),Xe=u):At(t,e),Dt(e),r&8192){if(u=e.memoizedState!==null,(e.stateNode.isHidden=u)&&!c&&(e.mode&1)!==0)for(W=e,c=e.child;c!==null;){for(d=W=c;W!==null;){switch(p=W,C=p.child,p.tag){case 0:case 11:case 14:case 15:go(4,p,p.return);break;case 1:vr(p,p.return);var S=p.stateNode;if(typeof S.componentWillUnmount=="function"){r=p,n=p.return;try{t=r,S.props=t.memoizedProps,S.state=t.memoizedState,S.componentWillUnmount()}catch(E){Ne(r,n,E)}}break;case 5:vr(p,p.return);break;case 22:if(p.memoizedState!==null){Sd(d);continue}}C!==null?(C.return=p,W=C):Sd(d)}c=c.sibling}e:for(c=null,d=e;;){if(d.tag===5){if(c===null){c=d;try{o=d.stateNode,u?(i=o.style,typeof i.setProperty=="function"?i.setProperty("display","none","important"):i.display="none"):(l=d.stateNode,a=d.memoizedProps.style,s=a!=null&&a.hasOwnProperty("display")?a.display:null,l.style.display=Tf("display",s))}catch(E){Ne(e,e.return,E)}}}else if(d.tag===6){if(c===null)try{d.stateNode.nodeValue=u?"":d.memoizedProps}catch(E){Ne(e,e.return,E)}}else if((d.tag!==22&&d.tag!==23||d.memoizedState===null||d===e)&&d.child!==null){d.child.return=d,d=d.child;continue}if(d===e)break e;for(;d.sibling===null;){if(d.return===null||d.return===e)break e;c===d&&(c=null),d=d.return}c===d&&(c=null),d.sibling.return=d.return,d=d.sibling}}break;case 19:At(t,e),Dt(e),r&4&&xd(e);break;case 21:break;default:At(t,e),Dt(e)}}function Dt(e){var t=e.flags;if(t&2){try{e:{for(var n=e.return;n!==null;){if(Jp(n)){var r=n;break e}n=n.return}throw Error(A(160))}switch(r.tag){case 5:var o=r.stateNode;r.flags&32&&(So(o,""),r.flags&=-33);var i=wd(e);ka(e,i,o);break;case 3:case 4:var s=r.stateNode.containerInfo,l=wd(e);xa(e,l,s);break;default:throw Error(A(161))}}catch(a){Ne(e,e.return,a)}e.flags&=-3}t&4096&&(e.flags&=-4097)}function Tg(e,t,n){W=e,nh(e)}function nh(e,t,n){for(var r=(e.mode&1)!==0;W!==null;){var o=W,i=o.child;if(o.tag===22&&r){var s=o.memoizedState!==null||ci;if(!s){var l=o.alternate,a=l!==null&&l.memoizedState!==null||Xe;l=ci;var u=Xe;if(ci=s,(Xe=a)&&!u)for(W=o;W!==null;)s=W,a=s.child,s.tag===22&&s.memoizedState!==null?_d(o):a!==null?(a.return=s,W=a):_d(o);for(;i!==null;)W=i,nh(i),i=i.sibling;W=o,ci=l,Xe=u}kd(e)}else(o.subtreeFlags&8772)!==0&&i!==null?(i.return=o,W=i):kd(e)}}function kd(e){for(;W!==null;){var t=W;if((t.flags&8772)!==0){var n=t.alternate;try{if((t.flags&8772)!==0)switch(t.tag){case 0:case 11:case 15:Xe||Es(5,t);break;case 1:var r=t.stateNode;if(t.flags&4&&!Xe)if(n===null)r.componentDidMount();else{var o=t.elementType===t.type?n.memoizedProps:Rt(t.type,n.memoizedProps);r.componentDidUpdate(o,n.memoizedState,r.__reactInternalSnapshotBeforeUpdate)}var i=t.updateQueue;i!==null&&od(t,i,r);break;case 3:var s=t.updateQueue;if(s!==null){if(n=null,t.child!==null)switch(t.child.tag){case 5:n=t.child.stateNode;break;case 1:n=t.child.stateNode}od(t,s,n)}break;case 5:var l=t.stateNode;if(n===null&&t.flags&4){n=l;var a=t.memoizedProps;switch(t.type){case"button":case"input":case"select":case"textarea":a.autoFocus&&n.focus();break;case"img":a.src&&(n.src=a.src)}}break;case 6:break;case 4:break;case 12:break;case 13:if(t.memoizedState===null){var u=t.alternate;if(u!==null){var c=u.memoizedState;if(c!==null){var d=c.dehydrated;d!==null&&To(d)}}}break;case 19:case 17:case 21:case 22:case 23:case 25:break;default:throw Error(A(163))}Xe||t.flags&512&&wa(t)}catch(p){Ne(t,t.return,p)}}if(t===e){W=null;break}if(n=t.sibling,n!==null){n.return=t.return,W=n;break}W=t.return}}function Sd(e){for(;W!==null;){var t=W;if(t===e){W=null;break}var n=t.sibling;if(n!==null){n.return=t.return,W=n;break}W=t.return}}function _d(e){for(;W!==null;){var t=W;try{switch(t.tag){case 0:case 11:case 15:var n=t.return;try{Es(4,t)}catch(a){Ne(t,n,a)}break;case 1:var r=t.stateNode;if(typeof r.componentDidMount=="function"){var o=t.return;try{r.componentDidMount()}catch(a){Ne(t,o,a)}}var i=t.return;try{wa(t)}catch(a){Ne(t,i,a)}break;case 5:var s=t.return;try{wa(t)}catch(a){Ne(t,s,a)}}}catch(a){Ne(t,t.return,a)}if(t===e){W=null;break}var l=t.sibling;if(l!==null){l.return=t.return,W=l;break}W=t.return}}var bg=Math.ceil,Ki=cn.ReactCurrentDispatcher,Bu=cn.ReactCurrentOwner,Tt=cn.ReactCurrentBatchConfig,ue=0,Ue=null,Oe=null,Qe=0,ht=0,wr=On(0),De=0,zo=null,Xn=0,Ts=0,Wu=0,yo=null,st=null,Hu=0,Ir=1/0,Kt=null,Xi=!1,Sa=null,En=null,di=!1,wn=null,qi=0,vo=0,_a=null,Ei=-1,Ti=0;function nt(){return(ue&6)!==0?Me():Ei!==-1?Ei:Ei=Me()}function Tn(e){return(e.mode&1)===0?1:(ue&2)!==0&&Qe!==0?Qe&-Qe:cg.transition!==null?(Ti===0&&(Ti=Df()),Ti):(e=ge,e!==0||(e=window.event,e=e===void 0?16:Zf(e.type)),e)}function Ot(e,t,n,r){if(50<vo)throw vo=0,_a=null,Error(A(185));Uo(e,n,r),((ue&2)===0||e!==Ue)&&(e===Ue&&((ue&2)===0&&(Ts|=n),De===4&&yn(e,Qe)),ct(e,r),n===1&&ue===0&&(t.mode&1)===0&&(Ir=Me()+500,Ss&&zn()))}function ct(e,t){var n=e.callbackNode;c0(e,t);var r=Mi(e,e===Ue?Qe:0);if(r===0)n!==null&&Nc(n),e.callbackNode=null,e.callbackPriority=0;else if(t=r&-r,e.callbackPriority!==t){if(n!=null&&Nc(n),t===1)e.tag===0?ug(Cd.bind(null,e)):dp(Cd.bind(null,e)),ig(function(){(ue&6)===0&&zn()}),n=null;else{switch(jf(r)){case 1:n=yu;break;case 4:n=zf;break;case 16:n=Li;break;case 536870912:n=If;break;default:n=Li}n=ch(n,rh.bind(null,e))}e.callbackPriority=t,e.callbackNode=n}}function rh(e,t){if(Ei=-1,Ti=0,(ue&6)!==0)throw Error(A(327));var n=e.callbackNode;if(Pr()&&e.callbackNode!==n)return null;var r=Mi(e,e===Ue?Qe:0);if(r===0)return null;if((r&30)!==0||(r&e.expiredLanes)!==0||t)t=Ji(e,r);else{t=r;var o=ue;ue|=2;var i=ih();(Ue!==e||Qe!==t)&&(Kt=null,Ir=Me()+500,Zn(e,t));do try{Ag();break}catch(l){oh(e,l)}while(1);Au(),Ki.current=i,ue=o,Oe!==null?t=0:(Ue=null,Qe=0,t=De)}if(t!==0){if(t===2&&(o=Kl(e),o!==0&&(r=o,t=Ca(e,o))),t===1)throw n=zo,Zn(e,0),yn(e,r),ct(e,Me()),n;if(t===6)yn(e,r);else{if(o=e.current.alternate,(r&30)===0&&!$g(o)&&(t=Ji(e,r),t===2&&(i=Kl(e),i!==0&&(r=i,t=Ca(e,i))),t===1))throw n=zo,Zn(e,0),yn(e,r),ct(e,Me()),n;switch(e.finishedWork=o,e.finishedLanes=r,t){case 0:case 1:throw Error(A(345));case 2:jn(e,st,Kt);break;case 3:if(yn(e,r),(r&130023424)===r&&(t=Hu+500-Me(),10<t)){if(Mi(e,0)!==0)break;if(o=e.suspendedLanes,(o&r)!==r){nt(),e.pingedLanes|=e.suspendedLanes&o;break}e.timeoutHandle=oa(jn.bind(null,e,st,Kt),t);break}jn(e,st,Kt);break;case 4:if(yn(e,r),(r&4194240)===r)break;for(t=e.eventTimes,o=-1;0<r;){var s=31-Mt(r);i=1<<s,s=t[s],s>o&&(o=s),r&=~i}if(r=o,r=Me()-r,r=(120>r?120:480>r?480:1080>r?1080:1920>r?1920:3e3>r?3e3:4320>r?4320:1960*bg(r/1960))-r,10<r){e.timeoutHandle=oa(jn.bind(null,e,st,Kt),r);break}jn(e,st,Kt);break;case 5:jn(e,st,Kt);break;default:throw Error(A(329))}}}return ct(e,Me()),e.callbackNode===n?rh.bind(null,e):null}function Ca(e,t){var n=yo;return e.current.memoizedState.isDehydrated&&(Zn(e,t).flags|=256),e=Ji(e,t),e!==2&&(t=st,st=n,t!==null&&Ea(t)),e}function Ea(e){st===null?st=e:st.push.apply(st,e)}function $g(e){for(var t=e;;){if(t.flags&16384){var n=t.updateQueue;if(n!==null&&(n=n.stores,n!==null))for(var r=0;r<n.length;r++){var o=n[r],i=o.getSnapshot;o=o.value;try{if(!zt(i(),o))return!1}catch{return!1}}}if(n=t.child,t.subtreeFlags&16384&&n!==null)n.return=t,t=n;else{if(t===e)break;for(;t.sibling===null;){if(t.return===null||t.return===e)return!0;t=t.return}t.sibling.return=t.return,t=t.sibling}}return!0}function yn(e,t){for(t&=~Wu,t&=~Ts,e.suspendedLanes|=t,e.pingedLanes&=~t,e=e.expirationTimes;0<t;){var n=31-Mt(t),r=1<<n;e[n]=-1,t&=~r}}function Cd(e){if((ue&6)!==0)throw Error(A(327));Pr();var t=Mi(e,0);if((t&1)===0)return ct(e,Me()),null;var n=Ji(e,t);if(e.tag!==0&&n===2){var r=Kl(e);r!==0&&(t=r,n=Ca(e,r))}if(n===1)throw n=zo,Zn(e,0),yn(e,t),ct(e,Me()),n;if(n===6)throw Error(A(345));return e.finishedWork=e.current.alternate,e.finishedLanes=t,jn(e,st,Kt),ct(e,Me()),null}function Zu(e,t){var n=ue;ue|=1;try{return e(t)}finally{ue=n,ue===0&&(Ir=Me()+500,Ss&&zn())}}function qn(e){wn!==null&&wn.tag===0&&(ue&6)===0&&Pr();var t=ue;ue|=1;var n=Tt.transition,r=ge;try{if(Tt.transition=null,ge=1,e)return e()}finally{ge=r,Tt.transition=n,ue=t,(ue&6)===0&&zn()}}function Qu(){ht=wr.current,_e(wr)}function Zn(e,t){e.finishedWork=null,e.finishedLanes=0;var n=e.timeoutHandle;if(n!==-1&&(e.timeoutHandle=-1,og(n)),Oe!==null)for(n=Oe.return;n!==null;){var r=n;switch(bu(r),r.tag){case 1:r=r.type.childContextTypes,r!=null&&ji();break;case 3:Or(),_e(at),_e(qe),Ou();break;case 5:Mu(r);break;case 4:Or();break;case 13:_e($e);break;case 19:_e($e);break;case 10:Ru(r.type._context);break;case 22:case 23:Qu()}n=n.return}if(Ue=e,Oe=e=bn(e.current,null),Qe=ht=t,De=0,zo=null,Wu=Ts=Xn=0,st=yo=null,Wn!==null){for(t=0;t<Wn.length;t++)if(n=Wn[t],r=n.interleaved,r!==null){n.interleaved=null;var o=r.next,i=n.pending;if(i!==null){var s=i.next;i.next=o,r.next=s}n.pending=r}Wn=null}return e}function oh(e,t){do{var n=Oe;try{if(Au(),Si.current=Gi,Yi){for(var r=Pe.memoizedState;r!==null;){var o=r.queue;o!==null&&(o.pending=null),r=r.next}Yi=!1}if(Kn=0,Ve=Ie=Pe=null,mo=!1,Lo=0,Bu.current=null,n===null||n.return===null){De=1,zo=t,Oe=null;break}e:{var i=e,s=n.return,l=n,a=t;if(t=Qe,l.flags|=32768,a!==null&&typeof a=="object"&&typeof a.then=="function"){var u=a,c=l,d=c.tag;if((c.mode&1)===0&&(d===0||d===11||d===15)){var p=c.alternate;p?(c.updateQueue=p.updateQueue,c.memoizedState=p.memoizedState,c.lanes=p.lanes):(c.updateQueue=null,c.memoizedState=null)}var C=dd(s);if(C!==null){C.flags&=-257,fd(C,s,l,i,t),C.mode&1&&cd(i,u,t),t=C,a=u;var S=t.updateQueue;if(S===null){var E=new Set;E.add(a),t.updateQueue=E}else S.add(a);break e}else{if((t&1)===0){cd(i,u,t),Yu();break e}a=Error(A(426))}}else if(Ee&&l.mode&1){var M=dd(s);if(M!==null){(M.flags&65536)===0&&(M.flags|=256),fd(M,s,l,i,t),$u(zr(a,l));break e}}i=a=zr(a,l),De!==4&&(De=2),yo===null?yo=[i]:yo.push(i),i=s;do{switch(i.tag){case 3:i.flags|=65536,t&=-t,i.lanes|=t;var h=Vp(i,a,t);rd(i,h);break e;case 1:l=a;var f=i.type,g=i.stateNode;if((i.flags&128)===0&&(typeof f.getDerivedStateFromError=="function"||g!==null&&typeof g.componentDidCatch=="function"&&(En===null||!En.has(g)))){i.flags|=65536,t&=-t,i.lanes|=t;var x=Up(i,l,t);rd(i,x);break e}}i=i.return}while(i!==null)}lh(n)}catch($){t=$,Oe===n&&n!==null&&(Oe=n=n.return);continue}break}while(1)}function ih(){var e=Ki.current;return Ki.current=Gi,e===null?Gi:e}function Yu(){(De===0||De===3||De===2)&&(De=4),Ue===null||(Xn&268435455)===0&&(Ts&268435455)===0||yn(Ue,Qe)}function Ji(e,t){var n=ue;ue|=2;var r=ih();(Ue!==e||Qe!==t)&&(Kt=null,Zn(e,t));do try{Pg();break}catch(o){oh(e,o)}while(1);if(Au(),ue=n,Ki.current=r,Oe!==null)throw Error(A(261));return Ue=null,Qe=0,De}function Pg(){for(;Oe!==null;)sh(Oe)}function Ag(){for(;Oe!==null&&!t0();)sh(Oe)}function sh(e){var t=uh(e.alternate,e,ht);e.memoizedProps=e.pendingProps,t===null?lh(e):Oe=t,Bu.current=null}function lh(e){var t=e;do{var n=t.alternate;if(e=t.return,(t.flags&32768)===0){if(n=Sg(n,t,ht),n!==null){Oe=n;return}}else{if(n=_g(n,t),n!==null){n.flags&=32767,Oe=n;return}if(e!==null)e.flags|=32768,e.subtreeFlags=0,e.deletions=null;else{De=6,Oe=null;return}}if(t=t.sibling,t!==null){Oe=t;return}Oe=t=e}while(t!==null);De===0&&(De=5)}function jn(e,t,n){var r=ge,o=Tt.transition;try{Tt.transition=null,ge=1,Rg(e,t,n,r)}finally{Tt.transition=o,ge=r}return null}function Rg(e,t,n,r){do Pr();while(wn!==null);if((ue&6)!==0)throw Error(A(327));n=e.finishedWork;var o=e.finishedLanes;if(n===null)return null;if(e.finishedWork=null,e.finishedLanes=0,n===e.current)throw Error(A(177));e.callbackNode=null,e.callbackPriority=0;var i=n.lanes|n.childLanes;if(d0(e,i),e===Ue&&(Oe=Ue=null,Qe=0),(n.subtreeFlags&2064)===0&&(n.flags&2064)===0||di||(di=!0,ch(Li,function(){return Pr(),null})),i=(n.flags&15990)!==0,(n.subtreeFlags&15990)!==0||i){i=Tt.transition,Tt.transition=null;var s=ge;ge=1;var l=ue;ue|=4,Bu.current=null,Eg(e,n),th(n,e),X0(na),Oi=!!ta,na=ta=null,e.current=n,Tg(n),n0(),ue=l,ge=s,Tt.transition=i}else e.current=n;if(di&&(di=!1,wn=e,qi=o),i=e.pendingLanes,i===0&&(En=null),i0(n.stateNode),ct(e,Me()),t!==null)for(r=e.onRecoverableError,n=0;n<t.length;n++)o=t[n],r(o.value,{componentStack:o.stack,digest:o.digest});if(Xi)throw Xi=!1,e=Sa,Sa=null,e;return(qi&1)!==0&&e.tag!==0&&Pr(),i=e.pendingLanes,(i&1)!==0?e===_a?vo++:(vo=0,_a=e):vo=0,zn(),null}function Pr(){if(wn!==null){var e=jf(qi),t=Tt.transition,n=ge;try{if(Tt.transition=null,ge=16>e?16:e,wn===null)var r=!1;else{if(e=wn,wn=null,qi=0,(ue&6)!==0)throw Error(A(331));var o=ue;for(ue|=4,W=e.current;W!==null;){var i=W,s=i.child;if((W.flags&16)!==0){var l=i.deletions;if(l!==null){for(var a=0;a<l.length;a++){var u=l[a];for(W=u;W!==null;){var c=W;switch(c.tag){case 0:case 11:case 15:go(8,c,i)}var d=c.child;if(d!==null)d.return=c,W=d;else for(;W!==null;){c=W;var p=c.sibling,C=c.return;if(qp(c),c===u){W=null;break}if(p!==null){p.return=C,W=p;break}W=C}}}var S=i.alternate;if(S!==null){var E=S.child;if(E!==null){S.child=null;do{var M=E.sibling;E.sibling=null,E=M}while(E!==null)}}W=i}}if((i.subtreeFlags&2064)!==0&&s!==null)s.return=i,W=s;else e:for(;W!==null;){if(i=W,(i.flags&2048)!==0)switch(i.tag){case 0:case 11:case 15:go(9,i,i.return)}var h=i.sibling;if(h!==null){h.return=i.return,W=h;break e}W=i.return}}var f=e.current;for(W=f;W!==null;){s=W;var g=s.child;if((s.subtreeFlags&2064)!==0&&g!==null)g.return=s,W=g;else e:for(s=f;W!==null;){if(l=W,(l.flags&2048)!==0)try{switch(l.tag){case 0:case 11:case 15:Es(9,l)}}catch($){Ne(l,l.return,$)}if(l===s){W=null;break e}var x=l.sibling;if(x!==null){x.return=l.return,W=x;break e}W=l.return}}if(ue=o,zn(),Ht&&typeof Ht.onPostCommitFiberRoot=="function")try{Ht.onPostCommitFiberRoot(ys,e)}catch{}r=!0}return r}finally{ge=n,Tt.transition=t}}return!1}function Ed(e,t,n){t=zr(n,t),t=Vp(e,t,1),e=Cn(e,t,1),t=nt(),e!==null&&(Uo(e,1,t),ct(e,t))}function Ne(e,t,n){if(e.tag===3)Ed(e,e,n);else for(;t!==null;){if(t.tag===3){Ed(t,e,n);break}else if(t.tag===1){var r=t.stateNode;if(typeof t.type.getDerivedStateFromError=="function"||typeof r.componentDidCatch=="function"&&(En===null||!En.has(r))){e=zr(n,e),e=Up(t,e,1),t=Cn(t,e,1),e=nt(),t!==null&&(Uo(t,1,e),ct(t,e));break}}t=t.return}}function Ng(e,t,n){var r=e.pingCache;r!==null&&r.delete(t),t=nt(),e.pingedLanes|=e.suspendedLanes&n,Ue===e&&(Qe&n)===n&&(De===4||De===3&&(Qe&130023424)===Qe&&500>Me()-Hu?Zn(e,0):Wu|=n),ct(e,t)}function ah(e,t){t===0&&((e.mode&1)===0?t=1:(t=ti,ti<<=1,(ti&130023424)===0&&(ti=4194304)));var n=nt();e=sn(e,t),e!==null&&(Uo(e,t,n),ct(e,n))}function Fg(e){var t=e.memoizedState,n=0;t!==null&&(n=t.retryLane),ah(e,n)}function Lg(e,t){var n=0;switch(e.tag){case 13:var r=e.stateNode,o=e.memoizedState;o!==null&&(n=o.retryLane);break;case 19:r=e.stateNode;break;default:throw Error(A(314))}r!==null&&r.delete(t),ah(e,n)}var uh;uh=function(e,t,n){if(e!==null)if(e.memoizedProps!==t.pendingProps||at.current)lt=!0;else{if((e.lanes&n)===0&&(t.flags&128)===0)return lt=!1,kg(e,t,n);lt=(e.flags&131072)!==0}else lt=!1,Ee&&(t.flags&1048576)!==0&&fp(t,Bi,t.index);switch(t.lanes=0,t.tag){case 2:var r=t.type;Ci(e,t),e=t.pendingProps;var o=Fr(t,qe.current);$r(t,n),o=Iu(null,t,r,e,o,n);var i=Du();return t.flags|=1,typeof o=="object"&&o!==null&&typeof o.render=="function"&&o.$$typeof===void 0?(t.tag=1,t.memoizedState=null,t.updateQueue=null,ut(r)?(i=!0,Vi(t)):i=!1,t.memoizedState=o.state!==null&&o.state!==void 0?o.state:null,Fu(t),o.updater=_s,t.stateNode=o,o._reactInternals=t,da(t,r,e,n),t=ha(null,t,r,!0,i,n)):(t.tag=0,Ee&&i&&Tu(t),et(null,t,o,n),t=t.child),t;case 16:r=t.elementType;e:{switch(Ci(e,t),e=t.pendingProps,o=r._init,r=o(r._payload),t.type=r,o=t.tag=Og(r),e=Rt(r,e),o){case 0:t=pa(null,t,r,e,n);break e;case 1:t=md(null,t,r,e,n);break e;case 11:t=pd(null,t,r,e,n);break e;case 14:t=hd(null,t,r,Rt(r.type,e),n);break e}throw Error(A(306,r,""))}return t;case 0:return r=t.type,o=t.pendingProps,o=t.elementType===r?o:Rt(r,o),pa(e,t,r,o,n);case 1:return r=t.type,o=t.pendingProps,o=t.elementType===r?o:Rt(r,o),md(e,t,r,o,n);case 3:e:{if(Zp(t),e===null)throw Error(A(387));r=t.pendingProps,i=t.memoizedState,o=i.element,gp(e,t),Zi(t,r,null,n);var s=t.memoizedState;if(r=s.element,i.isDehydrated)if(i={element:r,isDehydrated:!1,cache:s.cache,pendingSuspenseBoundaries:s.pendingSuspenseBoundaries,transitions:s.transitions},t.updateQueue.baseState=i,t.memoizedState=i,t.flags&256){o=zr(Error(A(423)),t),t=gd(e,t,r,n,o);break e}else if(r!==o){o=zr(Error(A(424)),t),t=gd(e,t,r,n,o);break e}else for(mt=_n(t.stateNode.containerInfo.firstChild),gt=t,Ee=!0,Ft=null,n=xp(t,null,r,n),t.child=n;n;)n.flags=n.flags&-3|4096,n=n.sibling;else{if(Lr(),r===o){t=ln(e,t,n);break e}et(e,t,r,n)}t=t.child}return t;case 5:return kp(t),e===null&&aa(t),r=t.type,o=t.pendingProps,i=e!==null?e.memoizedProps:null,s=o.children,ra(r,o)?s=null:i!==null&&ra(r,i)&&(t.flags|=32),Hp(e,t),et(e,t,s,n),t.child;case 6:return e===null&&aa(t),null;case 13:return Qp(e,t,n);case 4:return Lu(t,t.stateNode.containerInfo),r=t.pendingProps,e===null?t.child=Mr(t,null,r,n):et(e,t,r,n),t.child;case 11:return r=t.type,o=t.pendingProps,o=t.elementType===r?o:Rt(r,o),pd(e,t,r,o,n);case 7:return et(e,t,t.pendingProps,n),t.child;case 8:return et(e,t,t.pendingProps.children,n),t.child;case 12:return et(e,t,t.pendingProps.children,n),t.child;case 10:e:{if(r=t.type._context,o=t.pendingProps,i=t.memoizedProps,s=o.value,xe(Wi,r._currentValue),r._currentValue=s,i!==null)if(zt(i.value,s)){if(i.children===o.children&&!at.current){t=ln(e,t,n);break e}}else for(i=t.child,i!==null&&(i.return=t);i!==null;){var l=i.dependencies;if(l!==null){s=i.child;for(var a=l.firstContext;a!==null;){if(a.context===r){if(i.tag===1){a=tn(-1,n&-n),a.tag=2;var u=i.updateQueue;if(u!==null){u=u.shared;var c=u.pending;c===null?a.next=a:(a.next=c.next,c.next=a),u.pending=a}}i.lanes|=n,a=i.alternate,a!==null&&(a.lanes|=n),ua(i.return,n,t),l.lanes|=n;break}a=a.next}}else if(i.tag===10)s=i.type===t.type?null:i.child;else if(i.tag===18){if(s=i.return,s===null)throw Error(A(341));s.lanes|=n,l=s.alternate,l!==null&&(l.lanes|=n),ua(s,n,t),s=i.sibling}else s=i.child;if(s!==null)s.return=i;else for(s=i;s!==null;){if(s===t){s=null;break}if(i=s.sibling,i!==null){i.return=s.return,s=i;break}s=s.return}i=s}et(e,t,o.children,n),t=t.child}return t;case 9:return o=t.type,r=t.pendingProps.children,$r(t,n),o=bt(o),r=r(o),t.flags|=1,et(e,t,r,n),t.child;case 14:return r=t.type,o=Rt(r,t.pendingProps),o=Rt(r.type,o),hd(e,t,r,o,n);case 15:return Bp(e,t,t.type,t.pendingProps,n);case 17:return r=t.type,o=t.pendingProps,o=t.elementType===r?o:Rt(r,o),Ci(e,t),t.tag=1,ut(r)?(e=!0,Vi(t)):e=!1,$r(t,n),vp(t,r,o),da(t,r,o,n),ha(null,t,r,!0,e,n);case 19:return Yp(e,t,n);case 22:return Wp(e,t,n)}throw Error(A(156,t.tag))};function ch(e,t){return Of(e,t)}function Mg(e,t,n,r){this.tag=e,this.key=n,this.sibling=this.child=this.return=this.stateNode=this.type=this.elementType=null,this.index=0,this.ref=null,this.pendingProps=t,this.dependencies=this.memoizedState=this.updateQueue=this.memoizedProps=null,this.mode=r,this.subtreeFlags=this.flags=0,this.deletions=null,this.childLanes=this.lanes=0,this.alternate=null}function Et(e,t,n,r){return new Mg(e,t,n,r)}function Gu(e){return e=e.prototype,!(!e||!e.isReactComponent)}function Og(e){if(typeof e=="function")return Gu(e)?1:0;if(e!=null){if(e=e.$$typeof,e===hu)return 11;if(e===mu)return 14}return 2}function bn(e,t){var n=e.alternate;return n===null?(n=Et(e.tag,t,e.key,e.mode),n.elementType=e.elementType,n.type=e.type,n.stateNode=e.stateNode,n.alternate=e,e.alternate=n):(n.pendingProps=t,n.type=e.type,n.flags=0,n.subtreeFlags=0,n.deletions=null),n.flags=e.flags&14680064,n.childLanes=e.childLanes,n.lanes=e.lanes,n.child=e.child,n.memoizedProps=e.memoizedProps,n.memoizedState=e.memoizedState,n.updateQueue=e.updateQueue,t=e.dependencies,n.dependencies=t===null?null:{lanes:t.lanes,firstContext:t.firstContext},n.sibling=e.sibling,n.index=e.index,n.ref=e.ref,n}function bi(e,t,n,r,o,i){var s=2;if(r=e,typeof e=="function")Gu(e)&&(s=1);else if(typeof e=="string")s=5;else e:switch(e){case ur:return Qn(n.children,o,i,t);case pu:s=8,o|=8;break;case Ml:return e=Et(12,n,t,o|2),e.elementType=Ml,e.lanes=i,e;case Ol:return e=Et(13,n,t,o),e.elementType=Ol,e.lanes=i,e;case zl:return e=Et(19,n,t,o),e.elementType=zl,e.lanes=i,e;case wf:return bs(n,o,i,t);default:if(typeof e=="object"&&e!==null)switch(e.$$typeof){case yf:s=10;break e;case vf:s=9;break e;case hu:s=11;break e;case mu:s=14;break e;case hn:s=16,r=null;break e}throw Error(A(130,e==null?e:typeof e,""))}return t=Et(s,n,t,o),t.elementType=e,t.type=r,t.lanes=i,t}function Qn(e,t,n,r){return e=Et(7,e,r,t),e.lanes=n,e}function bs(e,t,n,r){return e=Et(22,e,r,t),e.elementType=wf,e.lanes=n,e.stateNode={isHidden:!1},e}function kl(e,t,n){return e=Et(6,e,null,t),e.lanes=n,e}function Sl(e,t,n){return t=Et(4,e.children!==null?e.children:[],e.key,t),t.lanes=n,t.stateNode={containerInfo:e.containerInfo,pendingChildren:null,implementation:e.implementation},t}function zg(e,t,n,r,o){this.tag=t,this.containerInfo=e,this.finishedWork=this.pingCache=this.current=this.pendingChildren=null,this.timeoutHandle=-1,this.callbackNode=this.pendingContext=this.context=null,this.callbackPriority=0,this.eventTimes=nl(0),this.expirationTimes=nl(-1),this.entangledLanes=this.finishedLanes=this.mutableReadLanes=this.expiredLanes=this.pingedLanes=this.suspendedLanes=this.pendingLanes=0,this.entanglements=nl(0),this.identifierPrefix=r,this.onRecoverableError=o,this.mutableSourceEagerHydrationData=null}function Ku(e,t,n,r,o,i,s,l,a){return e=new zg(e,t,n,l,a),t===1?(t=1,i===!0&&(t|=8)):t=0,i=Et(3,null,null,t),e.current=i,i.stateNode=e,i.memoizedState={element:r,isDehydrated:n,cache:null,transitions:null,pendingSuspenseBoundaries:null},Fu(i),e}function Ig(e,t,n){var r=3<arguments.length&&arguments[3]!==void 0?arguments[3]:null;return{$$typeof:ar,key:r==null?null:""+r,children:e,containerInfo:t,implementation:n}}function dh(e){if(!e)return Rn;e=e._reactInternals;e:{if(rr(e)!==e||e.tag!==1)throw Error(A(170));var t=e;do{switch(t.tag){case 3:t=t.stateNode.context;break e;case 1:if(ut(t.type)){t=t.stateNode.__reactInternalMemoizedMergedChildContext;break e}}t=t.return}while(t!==null);throw Error(A(171))}if(e.tag===1){var n=e.type;if(ut(n))return cp(e,n,t)}return t}function fh(e,t,n,r,o,i,s,l,a){return e=Ku(n,r,!0,e,o,i,s,l,a),e.context=dh(null),n=e.current,r=nt(),o=Tn(n),i=tn(r,o),i.callback=t!=null?t:null,Cn(n,i,o),e.current.lanes=o,Uo(e,o,r),ct(e,r),e}function $s(e,t,n,r){var o=t.current,i=nt(),s=Tn(o);return n=dh(n),t.context===null?t.context=n:t.pendingContext=n,t=tn(i,s),t.payload={element:e},r=r===void 0?null:r,r!==null&&(t.callback=r),e=Cn(o,t,s),e!==null&&(Ot(e,o,s,i),ki(e,o,s)),s}function es(e){if(e=e.current,!e.child)return null;switch(e.child.tag){case 5:return e.child.stateNode;default:return e.child.stateNode}}function Td(e,t){if(e=e.memoizedState,e!==null&&e.dehydrated!==null){var n=e.retryLane;e.retryLane=n!==0&&n<t?n:t}}function Xu(e,t){Td(e,t),(e=e.alternate)&&Td(e,t)}function Dg(){return null}var ph=typeof reportError=="function"?reportError:function(e){console.error(e)};function qu(e){this._internalRoot=e}Ps.prototype.render=qu.prototype.render=function(e){var t=this._internalRoot;if(t===null)throw Error(A(409));$s(e,t,null,null)};Ps.prototype.unmount=qu.prototype.unmount=function(){var e=this._internalRoot;if(e!==null){this._internalRoot=null;var t=e.containerInfo;qn(function(){$s(null,e,null,null)}),t[on]=null}};function Ps(e){this._internalRoot=e}Ps.prototype.unstable_scheduleHydration=function(e){if(e){var t=Bf();e={blockedOn:null,target:e,priority:t};for(var n=0;n<gn.length&&t!==0&&t<gn[n].priority;n++);gn.splice(n,0,e),n===0&&Hf(e)}};function Ju(e){return!(!e||e.nodeType!==1&&e.nodeType!==9&&e.nodeType!==11)}function As(e){return!(!e||e.nodeType!==1&&e.nodeType!==9&&e.nodeType!==11&&(e.nodeType!==8||e.nodeValue!==" react-mount-point-unstable "))}function bd(){}function jg(e,t,n,r,o){if(o){if(typeof r=="function"){var i=r;r=function(){var u=es(s);i.call(u)}}var s=fh(t,r,e,0,null,!1,!1,"",bd);return e._reactRootContainer=s,e[on]=s.current,Po(e.nodeType===8?e.parentNode:e),qn(),s}for(;o=e.lastChild;)e.removeChild(o);if(typeof r=="function"){var l=r;r=function(){var u=es(a);l.call(u)}}var a=Ku(e,0,!1,null,null,!1,!1,"",bd);return e._reactRootContainer=a,e[on]=a.current,Po(e.nodeType===8?e.parentNode:e),qn(function(){$s(t,a,n,r)}),a}function Rs(e,t,n,r,o){var i=n._reactRootContainer;if(i){var s=i;if(typeof o=="function"){var l=o;o=function(){var a=es(s);l.call(a)}}$s(t,s,e,o)}else s=jg(n,t,e,o,r);return es(s)}Vf=function(e){switch(e.tag){case 3:var t=e.stateNode;if(t.current.memoizedState.isDehydrated){var n=so(t.pendingLanes);n!==0&&(vu(t,n|1),ct(t,Me()),(ue&6)===0&&(Ir=Me()+500,zn()))}break;case 13:qn(function(){var r=sn(e,1);if(r!==null){var o=nt();Ot(r,e,1,o)}}),Xu(e,1)}};wu=function(e){if(e.tag===13){var t=sn(e,134217728);if(t!==null){var n=nt();Ot(t,e,134217728,n)}Xu(e,134217728)}};Uf=function(e){if(e.tag===13){var t=Tn(e),n=sn(e,t);if(n!==null){var r=nt();Ot(n,e,t,r)}Xu(e,t)}};Bf=function(){return ge};Wf=function(e,t){var n=ge;try{return ge=e,t()}finally{ge=n}};Ql=function(e,t,n){switch(t){case"input":if(jl(e,n),t=n.name,n.type==="radio"&&t!=null){for(n=e;n.parentNode;)n=n.parentNode;for(n=n.querySelectorAll("input[name="+JSON.stringify(""+t)+'][type="radio"]'),t=0;t<n.length;t++){var r=n[t];if(r!==e&&r.form===e.form){var o=ks(r);if(!o)throw Error(A(90));kf(r),jl(r,o)}}}break;case"textarea":_f(e,n);break;case"select":t=n.value,t!=null&&Cr(e,!!n.multiple,t,!1)}};Af=Zu;Rf=qn;var Vg={usingClientEntryPoint:!1,Events:[Wo,pr,ks,$f,Pf,Zu]},no={findFiberByHostInstance:Bn,bundleType:0,version:"18.2.0",rendererPackageName:"react-dom"},Ug={bundleType:no.bundleType,version:no.version,rendererPackageName:no.rendererPackageName,rendererConfig:no.rendererConfig,overrideHookState:null,overrideHookStateDeletePath:null,overrideHookStateRenamePath:null,overrideProps:null,overridePropsDeletePath:null,overridePropsRenamePath:null,setErrorHandler:null,setSuspenseHandler:null,scheduleUpdate:null,currentDispatcherRef:cn.ReactCurrentDispatcher,findHostInstanceByFiber:function(e){return e=Lf(e),e===null?null:e.stateNode},findFiberByHostInstance:no.findFiberByHostInstance||Dg,findHostInstancesForRefresh:null,scheduleRefresh:null,scheduleRoot:null,setRefreshHandler:null,getCurrentFiber:null,reconcilerVersion:"18.2.0-next-9e3b772b8-20220608"};if(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__<"u"){var fi=__REACT_DEVTOOLS_GLOBAL_HOOK__;if(!fi.isDisabled&&fi.supportsFiber)try{ys=fi.inject(Ug),Ht=fi}catch{}}vt.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED=Vg;vt.createPortal=function(e,t){var n=2<arguments.length&&arguments[2]!==void 0?arguments[2]:null;if(!Ju(t))throw Error(A(200));return Ig(e,t,null,n)};vt.createRoot=function(e,t){if(!Ju(e))throw Error(A(299));var n=!1,r="",o=ph;return t!=null&&(t.unstable_strictMode===!0&&(n=!0),t.identifierPrefix!==void 0&&(r=t.identifierPrefix),t.onRecoverableError!==void 0&&(o=t.onRecoverableError)),t=Ku(e,1,!1,null,null,n,!1,r,o),e[on]=t.current,Po(e.nodeType===8?e.parentNode:e),new qu(t)};vt.findDOMNode=function(e){if(e==null)return null;if(e.nodeType===1)return e;var t=e._reactInternals;if(t===void 0)throw typeof e.render=="function"?Error(A(188)):(e=Object.keys(e).join(","),Error(A(268,e)));return e=Lf(t),e=e===null?null:e.stateNode,e};vt.flushSync=function(e){return qn(e)};vt.hydrate=function(e,t,n){if(!As(t))throw Error(A(200));return Rs(null,e,t,!0,n)};vt.hydrateRoot=function(e,t,n){if(!Ju(e))throw Error(A(405));var r=n!=null&&n.hydratedSources||null,o=!1,i="",s=ph;if(n!=null&&(n.unstable_strictMode===!0&&(o=!0),n.identifierPrefix!==void 0&&(i=n.identifierPrefix),n.onRecoverableError!==void 0&&(s=n.onRecoverableError)),t=fh(t,null,e,1,n!=null?n:null,o,!1,i,s),e[on]=t.current,Po(e),r)for(e=0;e<r.length;e++)n=r[e],o=n._getVersion,o=o(n._source),t.mutableSourceEagerHydrationData==null?t.mutableSourceEagerHydrationData=[n,o]:t.mutableSourceEagerHydrationData.push(n,o);return new Ps(t)};vt.render=function(e,t,n){if(!As(t))throw Error(A(200));return Rs(null,e,t,!1,n)};vt.unmountComponentAtNode=function(e){if(!As(e))throw Error(A(40));return e._reactRootContainer?(qn(function(){Rs(null,null,e,!1,function(){e._reactRootContainer=null,e[on]=null})}),!0):!1};vt.unstable_batchedUpdates=Zu;vt.unstable_renderSubtreeIntoContainer=function(e,t,n,r){if(!As(n))throw Error(A(200));if(e==null||e._reactInternals===void 0)throw Error(A(38));return Rs(e,t,n,!1,r)};vt.version="18.2.0-next-9e3b772b8-20220608";(function(e){function t(){if(!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__>"u"||typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE!="function"))try{__REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(t)}catch(n){console.error(n)}}t(),e.exports=vt})(of);var $d=of.exports;Fl.createRoot=$d.createRoot,Fl.hydrateRoot=$d.hydrateRoot;const Bg="de",Wg="VOLTAR",Hg="MONITORAR",Zg="ESPECTAR",Qg="CRIAR UM TIME",Yg="CRIAR",Gg="Nome",Kg="Digite aqui...",Xg="Senha",qg="Digite aqui...",Jg="Voc\xEA permite pessoas de assistir partidas",ey="ENTRAR NO GRUPO",ty="ENTRAR",ny="CRIAR EQUIPE",ry="Enviado por",oy="votou no modo",iy="digite sua mensagem",sy="VOTA\xC7\xC3O",ly="ESTAT\xCDSTICA",ay="KILLS",uy="MORTES",cy="K/D",dy={amountOfTotal:Bg,toBack:Wg,toMonitor:Hg,toSpectate:Zg,titleToCreateTeam:Qg,toCreate:Yg,inputNameLabel:Gg,inputNamePlaceHolder:Kg,inputPasswordLabel:Xg,inputPasswordPlaceHolder:qg,toggleAccessToSpectateDescription:Jg,titleToJoinInTeam:ey,toJoin:ty,requestToCreateTeam:ny,sendBy:ry,votedForTheMode:oy,typeYourMessage:iy,titleVote:sy,titleStatistic:ly,kills:ay,deaths:uy,killPerDeaths:cy};var Ns={exports:{}},Fs={};/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var fy=v.exports,py=Symbol.for("react.element"),hy=Symbol.for("react.fragment"),my=Object.prototype.hasOwnProperty,gy=fy.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,yy={key:!0,ref:!0,__self:!0,__source:!0};function hh(e,t,n){var r,o={},i=null,s=null;n!==void 0&&(i=""+n),t.key!==void 0&&(i=""+t.key),t.ref!==void 0&&(s=t.ref);for(r in t)my.call(t,r)&&!yy.hasOwnProperty(r)&&(o[r]=t[r]);if(e&&e.defaultProps)for(r in t=e.defaultProps,t)o[r]===void 0&&(o[r]=t[r]);return{$$typeof:py,type:e,key:i,ref:s,props:o,_owner:gy.current}}Fs.Fragment=hy;Fs.jsx=hh;Fs.jsxs=hh;(function(e){e.exports=Fs})(Ns);const mh=Ns.exports.Fragment,_=Ns.exports.jsx,ee=Ns.exports.jsxs,gh=v.exports.createContext(null),vy=({children:e})=>{const[t,n]=v.exports.useState(dy);return v.exports.useEffect(()=>{fetch(".//messages.json").then(r=>r.json()).then(r=>{n(r)})},[]),_(gh.Provider,{value:{messages:t,setMessages:n},children:e})},xt=()=>v.exports.useContext(gh),yh=v.exports.createContext({}),wy=()=>v.exports.useContext(yh),vh=new Set,dt=new WeakMap,Ar=new WeakMap,Jn=new WeakMap,Ta=new WeakMap,xy=new WeakMap,Dr=new WeakMap,ts=new WeakMap,ao=new WeakSet;let Nn;const en="__aa_tgt",ba="__aa_del",ky=e=>{const t=Ty(e);t&&t.forEach(n=>by(n))},Sy=e=>{e.forEach(t=>{t.target===Nn&&Cy(),dt.has(t.target)&&or(t.target)})};function _y(e){const t=Ta.get(e);t==null||t.disconnect();let n=dt.get(e),r=0;const o=5;n||(n=jr(e),dt.set(e,n));const{offsetWidth:i,offsetHeight:s}=Nn,a=[n.top-o,i-(n.left+o+n.width),s-(n.top+o+n.height),n.left-o].map(c=>`${-1*Math.floor(c)}px`).join(" "),u=new IntersectionObserver(()=>{++r>1&&or(e)},{root:Nn,threshold:1,rootMargin:a});u.observe(e),Ta.set(e,u)}function or(e){clearTimeout(ts.get(e));const t=Ls(e),n=typeof t=="function"?500:t.duration;ts.set(e,setTimeout(async()=>{const r=Jn.get(e);(!r||await r.finished)&&(dt.set(e,jr(e)),_y(e))},n))}function Cy(){clearTimeout(ts.get(Nn)),ts.set(Nn,setTimeout(()=>{vh.forEach(e=>Sh(e,t=>wh(()=>or(t))))},100))}function Ey(e){setTimeout(()=>{xy.set(e,setInterval(()=>wh(or.bind(null,e)),2e3))},Math.round(2e3*Math.random()))}function wh(e){typeof requestIdleCallback=="function"?requestIdleCallback(()=>e()):requestAnimationFrame(()=>e())}let $a,xr;typeof window<"u"&&(Nn=document.documentElement,$a=new MutationObserver(ky),xr=new ResizeObserver(Sy),xr.observe(Nn));function Ty(e){return e.reduce((t,n)=>{if(t===!1)return!1;if(n.target instanceof Element){if(_l(n.target),!t.has(n.target)){t.add(n.target);for(let r=0;r<n.target.children.length;r++){const o=n.target.children.item(r);if(!!o){if(ba in o)return!1;_l(n.target,o),t.add(o)}}}if(n.removedNodes.length)for(let r=0;r<n.removedNodes.length;r++){const o=n.removedNodes[r];if(ba in o)return!1;o instanceof Element&&(t.add(o),_l(n.target,o),Ar.set(o,[n.previousSibling,n.nextSibling]))}}return t},new Set)}function _l(e,t){!t&&!(en in e)?Object.defineProperty(e,en,{value:e}):t&&!(en in t)&&Object.defineProperty(t,en,{value:e})}function by(e){var t;const n=Nn.contains(e),r=dt.has(e);n&&Ar.has(e)&&Ar.delete(e),Jn.has(e)&&((t=Jn.get(e))===null||t===void 0||t.cancel()),r&&n?$y(e):r&&!n?Ay(e):Py(e)}function Vt(e){return Number(e.replace(/[^0-9.\-]/g,""))}function jr(e){const t=e.getBoundingClientRect();return{top:t.top+window.scrollY,left:t.left+window.scrollX,width:t.width,height:t.height}}function xh(e,t,n){let r=t.width,o=t.height,i=n.width,s=n.height;const l=getComputedStyle(e);if(l.getPropertyValue("box-sizing")==="content-box"){const u=Vt(l.paddingTop)+Vt(l.paddingBottom)+Vt(l.borderTopWidth)+Vt(l.borderBottomWidth),c=Vt(l.paddingLeft)+Vt(l.paddingRight)+Vt(l.borderRightWidth)+Vt(l.borderLeftWidth);r-=c,i-=c,o-=u,s-=u}return[r,i,o,s].map(Math.round)}function Ls(e){return en in e&&Dr.has(e[en])?Dr.get(e[en]):{duration:250,easing:"ease-in-out"}}function kh(e){if(en in e)return e[en]}function ec(e){const t=kh(e);return t?ao.has(t):!1}function Sh(e,...t){t.forEach(n=>n(e,Dr.has(e)));for(let n=0;n<e.children.length;n++){const r=e.children.item(n);r&&t.forEach(o=>o(r,Dr.has(r)))}}function $y(e){const t=dt.get(e),n=jr(e);if(!ec(e))return dt.set(e,n);let r;if(!t)return;const o=Ls(e);if(typeof o!="function"){const i=t.left-n.left,s=t.top-n.top,[l,a,u,c]=xh(e,t,n),d={transform:`translate(${i}px, ${s}px)`},p={transform:"translate(0, 0)"};l!==a&&(d.width=`${l}px`,p.width=`${a}px`),u!==c&&(d.height=`${u}px`,p.height=`${c}px`),r=e.animate([d,p],{duration:o.duration,easing:o.easing})}else r=new Animation(o(e,"remain",t,n)),r.play();Jn.set(e,r),dt.set(e,n),r.addEventListener("finish",or.bind(null,e))}function Py(e){const t=jr(e);dt.set(e,t);const n=Ls(e);if(!ec(e))return;let r;typeof n!="function"?r=e.animate([{transform:"scale(.98)",opacity:0},{transform:"scale(0.98)",opacity:0,offset:.5},{transform:"scale(1)",opacity:1}],{duration:n.duration*1.5,easing:"ease-in"}):(r=new Animation(n(e,"add",t)),r.play()),Jn.set(e,r),r.addEventListener("finish",or.bind(null,e))}function Ay(e){var t;if(!Ar.has(e)||!dt.has(e))return;const[n,r]=Ar.get(e);Object.defineProperty(e,ba,{value:!0}),r&&r.parentNode&&r.parentNode instanceof Element?r.parentNode.insertBefore(e,r):n&&n.parentNode?n.parentNode.appendChild(e):(t=kh(e))===null||t===void 0||t.appendChild(e);function o(){var p;e.remove(),dt.delete(e),Ar.delete(e),Jn.delete(e),(p=Ta.get(e))===null||p===void 0||p.disconnect()}if(!ec(e))return o();const[i,s,l,a]=Ry(e),u=Ls(e),c=dt.get(e);let d;Object.assign(e.style,{position:"absolute",top:`${i}px`,left:`${s}px`,width:`${l}px`,height:`${a}px`,margin:0,pointerEvents:"none",transformOrigin:"center",zIndex:100}),typeof u!="function"?d=e.animate([{transform:"scale(1)",opacity:1},{transform:"scale(.98)",opacity:0}],{duration:u.duration,easing:"ease-out"}):(d=new Animation(u(e,"remove",c)),d.play()),Jn.set(e,d),d.addEventListener("finish",o)}function Ry(e){const t=dt.get(e),[n,,r]=xh(e,t,jr(e));let o=e.parentElement;for(;o&&(getComputedStyle(o).position==="static"||o instanceof HTMLBodyElement);)o=o.parentElement;o||(o=document.body);const i=getComputedStyle(o),s=dt.get(o)||jr(o),l=Math.round(t.top-s.top)-Vt(i.borderTopWidth),a=Math.round(t.left-s.left)-Vt(i.borderLeftWidth);return[l,a,n,r]}function Ny(e,t={}){return $a&&xr&&(window.matchMedia("(prefers-reduced-motion: reduce)").matches&&typeof t!="function"&&!t.disrespectUserMotionPreference||(ao.add(e),getComputedStyle(e).position==="static"&&Object.assign(e.style,{position:"relative"}),Sh(e,or,Ey,o=>xr==null?void 0:xr.observe(o)),typeof t=="function"?Dr.set(e,t):Dr.set(e,{duration:250,easing:"ease-in-out",...t}),$a.observe(e,{childList:!0}),vh.add(e))),Object.freeze({parent:e,enable:()=>{ao.add(e)},disable:()=>{ao.delete(e)},isEnabled:()=>ao.has(e)})}function Fy(e={}){const t=v.exports.useRef(null),[n,r]=v.exports.useState(),o=i=>{n&&(i?n.enable():n.disable())};return v.exports.useEffect(()=>{t.current instanceof HTMLElement&&r(Ny(t.current,e))},[]),[t,o]}const _h=v.exports.createContext({});function Ly(){return v.exports.useContext(_h)}var Ms={exports:{}},ye={};/** @license React v16.13.1
 * react-is.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */var We=typeof Symbol=="function"&&Symbol.for,tc=We?Symbol.for("react.element"):60103,nc=We?Symbol.for("react.portal"):60106,Os=We?Symbol.for("react.fragment"):60107,zs=We?Symbol.for("react.strict_mode"):60108,Is=We?Symbol.for("react.profiler"):60114,Ds=We?Symbol.for("react.provider"):60109,js=We?Symbol.for("react.context"):60110,rc=We?Symbol.for("react.async_mode"):60111,Vs=We?Symbol.for("react.concurrent_mode"):60111,Us=We?Symbol.for("react.forward_ref"):60112,Bs=We?Symbol.for("react.suspense"):60113,My=We?Symbol.for("react.suspense_list"):60120,Ws=We?Symbol.for("react.memo"):60115,Hs=We?Symbol.for("react.lazy"):60116,Oy=We?Symbol.for("react.block"):60121,zy=We?Symbol.for("react.fundamental"):60117,Iy=We?Symbol.for("react.responder"):60118,Dy=We?Symbol.for("react.scope"):60119;function kt(e){if(typeof e=="object"&&e!==null){var t=e.$$typeof;switch(t){case tc:switch(e=e.type,e){case rc:case Vs:case Os:case Is:case zs:case Bs:return e;default:switch(e=e&&e.$$typeof,e){case js:case Us:case Hs:case Ws:case Ds:return e;default:return t}}case nc:return t}}}function Ch(e){return kt(e)===Vs}ye.AsyncMode=rc;ye.ConcurrentMode=Vs;ye.ContextConsumer=js;ye.ContextProvider=Ds;ye.Element=tc;ye.ForwardRef=Us;ye.Fragment=Os;ye.Lazy=Hs;ye.Memo=Ws;ye.Portal=nc;ye.Profiler=Is;ye.StrictMode=zs;ye.Suspense=Bs;ye.isAsyncMode=function(e){return Ch(e)||kt(e)===rc};ye.isConcurrentMode=Ch;ye.isContextConsumer=function(e){return kt(e)===js};ye.isContextProvider=function(e){return kt(e)===Ds};ye.isElement=function(e){return typeof e=="object"&&e!==null&&e.$$typeof===tc};ye.isForwardRef=function(e){return kt(e)===Us};ye.isFragment=function(e){return kt(e)===Os};ye.isLazy=function(e){return kt(e)===Hs};ye.isMemo=function(e){return kt(e)===Ws};ye.isPortal=function(e){return kt(e)===nc};ye.isProfiler=function(e){return kt(e)===Is};ye.isStrictMode=function(e){return kt(e)===zs};ye.isSuspense=function(e){return kt(e)===Bs};ye.isValidElementType=function(e){return typeof e=="string"||typeof e=="function"||e===Os||e===Vs||e===Is||e===zs||e===Bs||e===My||typeof e=="object"&&e!==null&&(e.$$typeof===Hs||e.$$typeof===Ws||e.$$typeof===Ds||e.$$typeof===js||e.$$typeof===Us||e.$$typeof===zy||e.$$typeof===Iy||e.$$typeof===Dy||e.$$typeof===Oy)};ye.typeOf=kt;(function(e){e.exports=ye})(Ms);function jy(e){function t(O,V,U,X,w){for(var ie=0,L=0,Te=0,fe=0,m,y,k=0,N=0,P,b=P=m=0,R=0,oe=0,ze=0,Re=0,dn=U.length,In=dn-1,it,J="",Ce="",Gs="",Ks="",fn;R<dn;){if(y=U.charCodeAt(R),R===In&&L+fe+Te+ie!==0&&(L!==0&&(y=L===47?10:47),fe=Te=ie=0,dn++,In++),L+fe+Te+ie===0){if(R===In&&(0<oe&&(J=J.replace(p,"")),0<J.trim().length)){switch(y){case 32:case 9:case 59:case 13:case 10:break;default:J+=U.charAt(R)}y=59}switch(y){case 123:for(J=J.trim(),m=J.charCodeAt(0),P=1,Re=++R;R<dn;){switch(y=U.charCodeAt(R)){case 123:P++;break;case 125:P--;break;case 47:switch(y=U.charCodeAt(R+1)){case 42:case 47:e:{for(b=R+1;b<In;++b)switch(U.charCodeAt(b)){case 47:if(y===42&&U.charCodeAt(b-1)===42&&R+2!==b){R=b+1;break e}break;case 10:if(y===47){R=b+1;break e}}R=b}}break;case 91:y++;case 40:y++;case 34:case 39:for(;R++<In&&U.charCodeAt(R)!==y;);}if(P===0)break;R++}switch(P=U.substring(Re,R),m===0&&(m=(J=J.replace(d,"").trim()).charCodeAt(0)),m){case 64:switch(0<oe&&(J=J.replace(p,"")),y=J.charCodeAt(1),y){case 100:case 109:case 115:case 45:oe=V;break;default:oe=He}if(P=t(V,oe,P,y,w+1),Re=P.length,0<F&&(oe=n(He,J,ze),fn=l(3,P,oe,V,ae,Y,Re,y,w,X),J=oe.join(""),fn!==void 0&&(Re=(P=fn.trim()).length)===0&&(y=0,P="")),0<Re)switch(y){case 115:J=J.replace(z,s);case 100:case 109:case 45:P=J+"{"+P+"}";break;case 107:J=J.replace(f,"$1 $2"),P=J+"{"+P+"}",P=we===1||we===2&&i("@"+P,3)?"@-webkit-"+P+"@"+P:"@"+P;break;default:P=J+P,X===112&&(P=(Ce+=P,""))}else P="";break;default:P=t(V,n(V,J,ze),P,X,w+1)}Gs+=P,P=ze=oe=b=m=0,J="",y=U.charCodeAt(++R);break;case 125:case 59:if(J=(0<oe?J.replace(p,""):J).trim(),1<(Re=J.length))switch(b===0&&(m=J.charCodeAt(0),m===45||96<m&&123>m)&&(Re=(J=J.replace(" ",":")).length),0<F&&(fn=l(1,J,V,O,ae,Y,Ce.length,X,w,X))!==void 0&&(Re=(J=fn.trim()).length)===0&&(J="\0\0"),m=J.charCodeAt(0),y=J.charCodeAt(1),m){case 0:break;case 64:if(y===105||y===99){Ks+=J+U.charAt(R);break}default:J.charCodeAt(Re-1)!==58&&(Ce+=o(J,m,y,J.charCodeAt(2)))}ze=oe=b=m=0,J="",y=U.charCodeAt(++R)}}switch(y){case 13:case 10:L===47?L=0:1+m===0&&X!==107&&0<J.length&&(oe=1,J+="\0"),0<F*q&&l(0,J,V,O,ae,Y,Ce.length,X,w,X),Y=1,ae++;break;case 59:case 125:if(L+fe+Te+ie===0){Y++;break}default:switch(Y++,it=U.charAt(R),y){case 9:case 32:if(fe+ie+L===0)switch(k){case 44:case 58:case 9:case 32:it="";break;default:y!==32&&(it=" ")}break;case 0:it="\\0";break;case 12:it="\\f";break;case 11:it="\\v";break;case 38:fe+L+ie===0&&(oe=ze=1,it="\f"+it);break;case 108:if(fe+L+ie+ve===0&&0<b)switch(R-b){case 2:k===112&&U.charCodeAt(R-3)===58&&(ve=k);case 8:N===111&&(ve=N)}break;case 58:fe+L+ie===0&&(b=R);break;case 44:L+Te+fe+ie===0&&(oe=1,it+="\r");break;case 34:case 39:L===0&&(fe=fe===y?0:fe===0?y:fe);break;case 91:fe+L+Te===0&&ie++;break;case 93:fe+L+Te===0&&ie--;break;case 41:fe+L+ie===0&&Te--;break;case 40:if(fe+L+ie===0){if(m===0)switch(2*k+3*N){case 533:break;default:m=1}Te++}break;case 64:L+Te+fe+ie+b+P===0&&(P=1);break;case 42:case 47:if(!(0<fe+ie+Te))switch(L){case 0:switch(2*y+3*U.charCodeAt(R+1)){case 235:L=47;break;case 220:Re=R,L=42}break;case 42:y===47&&k===42&&Re+2!==R&&(U.charCodeAt(Re+2)===33&&(Ce+=U.substring(Re,R+1)),it="",L=0)}}L===0&&(J+=it)}N=k,k=y,R++}if(Re=Ce.length,0<Re){if(oe=V,0<F&&(fn=l(2,Ce,oe,O,ae,Y,Re,X,w,X),fn!==void 0&&(Ce=fn).length===0))return Ks+Ce+Gs;if(Ce=oe.join(",")+"{"+Ce+"}",we*ve!==0){switch(we!==2||i(Ce,2)||(ve=0),ve){case 111:Ce=Ce.replace(x,":-moz-$1")+Ce;break;case 112:Ce=Ce.replace(g,"::-webkit-input-$1")+Ce.replace(g,"::-moz-$1")+Ce.replace(g,":-ms-input-$1")+Ce}ve=0}}return Ks+Ce+Gs}function n(O,V,U){var X=V.trim().split(M);V=X;var w=X.length,ie=O.length;switch(ie){case 0:case 1:var L=0;for(O=ie===0?"":O[0]+" ";L<w;++L)V[L]=r(O,V[L],U).trim();break;default:var Te=L=0;for(V=[];L<w;++L)for(var fe=0;fe<ie;++fe)V[Te++]=r(O[fe]+" ",X[L],U).trim()}return V}function r(O,V,U){var X=V.charCodeAt(0);switch(33>X&&(X=(V=V.trim()).charCodeAt(0)),X){case 38:return V.replace(h,"$1"+O.trim());case 58:return O.trim()+V.replace(h,"$1"+O.trim());default:if(0<1*U&&0<V.indexOf("\f"))return V.replace(h,(O.charCodeAt(0)===58?"":"$1")+O.trim())}return O+V}function o(O,V,U,X){var w=O+";",ie=2*V+3*U+4*X;if(ie===944){O=w.indexOf(":",9)+1;var L=w.substring(O,w.length-1).trim();return L=w.substring(0,O).trim()+L+";",we===1||we===2&&i(L,1)?"-webkit-"+L+L:L}if(we===0||we===2&&!i(w,1))return w;switch(ie){case 1015:return w.charCodeAt(10)===97?"-webkit-"+w+w:w;case 951:return w.charCodeAt(3)===116?"-webkit-"+w+w:w;case 963:return w.charCodeAt(5)===110?"-webkit-"+w+w:w;case 1009:if(w.charCodeAt(4)!==100)break;case 969:case 942:return"-webkit-"+w+w;case 978:return"-webkit-"+w+"-moz-"+w+w;case 1019:case 983:return"-webkit-"+w+"-moz-"+w+"-ms-"+w+w;case 883:if(w.charCodeAt(8)===45)return"-webkit-"+w+w;if(0<w.indexOf("image-set(",11))return w.replace(Z,"$1-webkit-$2")+w;break;case 932:if(w.charCodeAt(4)===45)switch(w.charCodeAt(5)){case 103:return"-webkit-box-"+w.replace("-grow","")+"-webkit-"+w+"-ms-"+w.replace("grow","positive")+w;case 115:return"-webkit-"+w+"-ms-"+w.replace("shrink","negative")+w;case 98:return"-webkit-"+w+"-ms-"+w.replace("basis","preferred-size")+w}return"-webkit-"+w+"-ms-"+w+w;case 964:return"-webkit-"+w+"-ms-flex-"+w+w;case 1023:if(w.charCodeAt(8)!==99)break;return L=w.substring(w.indexOf(":",15)).replace("flex-","").replace("space-between","justify"),"-webkit-box-pack"+L+"-webkit-"+w+"-ms-flex-pack"+L+w;case 1005:return S.test(w)?w.replace(C,":-webkit-")+w.replace(C,":-moz-")+w:w;case 1e3:switch(L=w.substring(13).trim(),V=L.indexOf("-")+1,L.charCodeAt(0)+L.charCodeAt(V)){case 226:L=w.replace($,"tb");break;case 232:L=w.replace($,"tb-rl");break;case 220:L=w.replace($,"lr");break;default:return w}return"-webkit-"+w+"-ms-"+L+w;case 1017:if(w.indexOf("sticky",9)===-1)break;case 975:switch(V=(w=O).length-10,L=(w.charCodeAt(V)===33?w.substring(0,V):w).substring(O.indexOf(":",7)+1).trim(),ie=L.charCodeAt(0)+(L.charCodeAt(7)|0)){case 203:if(111>L.charCodeAt(8))break;case 115:w=w.replace(L,"-webkit-"+L)+";"+w;break;case 207:case 102:w=w.replace(L,"-webkit-"+(102<ie?"inline-":"")+"box")+";"+w.replace(L,"-webkit-"+L)+";"+w.replace(L,"-ms-"+L+"box")+";"+w}return w+";";case 938:if(w.charCodeAt(5)===45)switch(w.charCodeAt(6)){case 105:return L=w.replace("-items",""),"-webkit-"+w+"-webkit-box-"+L+"-ms-flex-"+L+w;case 115:return"-webkit-"+w+"-ms-flex-item-"+w.replace(I,"")+w;default:return"-webkit-"+w+"-ms-flex-line-pack"+w.replace("align-content","").replace(I,"")+w}break;case 973:case 989:if(w.charCodeAt(3)!==45||w.charCodeAt(4)===122)break;case 931:case 953:if(K.test(O)===!0)return(L=O.substring(O.indexOf(":")+1)).charCodeAt(0)===115?o(O.replace("stretch","fill-available"),V,U,X).replace(":fill-available",":stretch"):w.replace(L,"-webkit-"+L)+w.replace(L,"-moz-"+L.replace("fill-",""))+w;break;case 962:if(w="-webkit-"+w+(w.charCodeAt(5)===102?"-ms-"+w:"")+w,U+X===211&&w.charCodeAt(13)===105&&0<w.indexOf("transform",10))return w.substring(0,w.indexOf(";",27)+1).replace(E,"$1-webkit-$2")+w}return w}function i(O,V){var U=O.indexOf(V===1?":":"{"),X=O.substring(0,V!==3?U:10);return U=O.substring(U+1,O.length-1),G(V!==2?X:X.replace(te,"$1"),U,V)}function s(O,V){var U=o(V,V.charCodeAt(0),V.charCodeAt(1),V.charCodeAt(2));return U!==V+";"?U.replace(D," or ($1)").substring(4):"("+V+")"}function l(O,V,U,X,w,ie,L,Te,fe,m){for(var y=0,k=V,N;y<F;++y)switch(N=je[y].call(c,O,k,U,X,w,ie,L,Te,fe,m)){case void 0:case!1:case!0:case null:break;default:k=N}if(k!==V)return k}function a(O){switch(O){case void 0:case null:F=je.length=0;break;default:if(typeof O=="function")je[F++]=O;else if(typeof O=="object")for(var V=0,U=O.length;V<U;++V)a(O[V]);else q=!!O|0}return a}function u(O){return O=O.prefix,O!==void 0&&(G=null,O?typeof O!="function"?we=1:(we=2,G=O):we=0),u}function c(O,V){var U=O;if(33>U.charCodeAt(0)&&(U=U.trim()),me=U,U=[me],0<F){var X=l(-1,V,U,U,ae,Y,0,0,0,0);X!==void 0&&typeof X=="string"&&(V=X)}var w=t(He,U,V,0,0);return 0<F&&(X=l(-2,w,U,U,ae,Y,w.length,0,0,0),X!==void 0&&(w=X)),me="",ve=0,Y=ae=1,w}var d=/^\0+/g,p=/[\0\r\f]/g,C=/: */g,S=/zoo|gra/,E=/([,: ])(transform)/g,M=/,\r+?/g,h=/([\t\r\n ])*\f?&/g,f=/@(k\w+)\s*(\S*)\s*/,g=/::(place)/g,x=/:(read-only)/g,$=/[svh]\w+-[tblr]{2}/,z=/\(\s*(.*)\s*\)/g,D=/([\s\S]*?);/g,I=/-self|flex-/g,te=/[^]*?(:[rp][el]a[\w-]+)[^]*/,K=/stretch|:\s*\w+\-(?:conte|avail)/,Z=/([^-])(image-set\()/,Y=1,ae=1,ve=0,we=1,He=[],je=[],F=0,G=null,q=0,me="";return c.use=a,c.set=u,e!==void 0&&u(e),c}var Vy={animationIterationCount:1,borderImageOutset:1,borderImageSlice:1,borderImageWidth:1,boxFlex:1,boxFlexGroup:1,boxOrdinalGroup:1,columnCount:1,columns:1,flex:1,flexGrow:1,flexPositive:1,flexShrink:1,flexNegative:1,flexOrder:1,gridRow:1,gridRowEnd:1,gridRowSpan:1,gridRowStart:1,gridColumn:1,gridColumnEnd:1,gridColumnSpan:1,gridColumnStart:1,msGridRow:1,msGridRowSpan:1,msGridColumn:1,msGridColumnSpan:1,fontWeight:1,lineHeight:1,opacity:1,order:1,orphans:1,tabSize:1,widows:1,zIndex:1,zoom:1,WebkitLineClamp:1,fillOpacity:1,floodOpacity:1,stopOpacity:1,strokeDasharray:1,strokeDashoffset:1,strokeMiterlimit:1,strokeOpacity:1,strokeWidth:1};function Uy(e){var t=Object.create(null);return function(n){return t[n]===void 0&&(t[n]=e(n)),t[n]}}var By=/^((children|dangerouslySetInnerHTML|key|ref|autoFocus|defaultValue|defaultChecked|innerHTML|suppressContentEditableWarning|suppressHydrationWarning|valueLink|abbr|accept|acceptCharset|accessKey|action|allow|allowUserMedia|allowPaymentRequest|allowFullScreen|allowTransparency|alt|async|autoComplete|autoPlay|capture|cellPadding|cellSpacing|challenge|charSet|checked|cite|classID|className|cols|colSpan|content|contentEditable|contextMenu|controls|controlsList|coords|crossOrigin|data|dateTime|decoding|default|defer|dir|disabled|disablePictureInPicture|download|draggable|encType|enterKeyHint|form|formAction|formEncType|formMethod|formNoValidate|formTarget|frameBorder|headers|height|hidden|high|href|hrefLang|htmlFor|httpEquiv|id|inputMode|integrity|is|keyParams|keyType|kind|label|lang|list|loading|loop|low|marginHeight|marginWidth|max|maxLength|media|mediaGroup|method|min|minLength|multiple|muted|name|nonce|noValidate|open|optimum|pattern|placeholder|playsInline|poster|preload|profile|radioGroup|readOnly|referrerPolicy|rel|required|reversed|role|rows|rowSpan|sandbox|scope|scoped|scrolling|seamless|selected|shape|size|sizes|slot|span|spellCheck|src|srcDoc|srcLang|srcSet|start|step|style|summary|tabIndex|target|title|translate|type|useMap|value|width|wmode|wrap|about|datatype|inlist|prefix|property|resource|typeof|vocab|autoCapitalize|autoCorrect|autoSave|color|incremental|fallback|inert|itemProp|itemScope|itemType|itemID|itemRef|on|option|results|security|unselectable|accentHeight|accumulate|additive|alignmentBaseline|allowReorder|alphabetic|amplitude|arabicForm|ascent|attributeName|attributeType|autoReverse|azimuth|baseFrequency|baselineShift|baseProfile|bbox|begin|bias|by|calcMode|capHeight|clip|clipPathUnits|clipPath|clipRule|colorInterpolation|colorInterpolationFilters|colorProfile|colorRendering|contentScriptType|contentStyleType|cursor|cx|cy|d|decelerate|descent|diffuseConstant|direction|display|divisor|dominantBaseline|dur|dx|dy|edgeMode|elevation|enableBackground|end|exponent|externalResourcesRequired|fill|fillOpacity|fillRule|filter|filterRes|filterUnits|floodColor|floodOpacity|focusable|fontFamily|fontSize|fontSizeAdjust|fontStretch|fontStyle|fontVariant|fontWeight|format|from|fr|fx|fy|g1|g2|glyphName|glyphOrientationHorizontal|glyphOrientationVertical|glyphRef|gradientTransform|gradientUnits|hanging|horizAdvX|horizOriginX|ideographic|imageRendering|in|in2|intercept|k|k1|k2|k3|k4|kernelMatrix|kernelUnitLength|kerning|keyPoints|keySplines|keyTimes|lengthAdjust|letterSpacing|lightingColor|limitingConeAngle|local|markerEnd|markerMid|markerStart|markerHeight|markerUnits|markerWidth|mask|maskContentUnits|maskUnits|mathematical|mode|numOctaves|offset|opacity|operator|order|orient|orientation|origin|overflow|overlinePosition|overlineThickness|panose1|paintOrder|pathLength|patternContentUnits|patternTransform|patternUnits|pointerEvents|points|pointsAtX|pointsAtY|pointsAtZ|preserveAlpha|preserveAspectRatio|primitiveUnits|r|radius|refX|refY|renderingIntent|repeatCount|repeatDur|requiredExtensions|requiredFeatures|restart|result|rotate|rx|ry|scale|seed|shapeRendering|slope|spacing|specularConstant|specularExponent|speed|spreadMethod|startOffset|stdDeviation|stemh|stemv|stitchTiles|stopColor|stopOpacity|strikethroughPosition|strikethroughThickness|string|stroke|strokeDasharray|strokeDashoffset|strokeLinecap|strokeLinejoin|strokeMiterlimit|strokeOpacity|strokeWidth|surfaceScale|systemLanguage|tableValues|targetX|targetY|textAnchor|textDecoration|textRendering|textLength|to|transform|u1|u2|underlinePosition|underlineThickness|unicode|unicodeBidi|unicodeRange|unitsPerEm|vAlphabetic|vHanging|vIdeographic|vMathematical|values|vectorEffect|version|vertAdvY|vertOriginX|vertOriginY|viewBox|viewTarget|visibility|widths|wordSpacing|writingMode|x|xHeight|x1|x2|xChannelSelector|xlinkActuate|xlinkArcrole|xlinkHref|xlinkRole|xlinkShow|xlinkTitle|xlinkType|xmlBase|xmlns|xmlnsXlink|xmlLang|xmlSpace|y|y1|y2|yChannelSelector|z|zoomAndPan|for|class|autofocus)|(([Dd][Aa][Tt][Aa]|[Aa][Rr][Ii][Aa]|x)-.*))$/,Pd=Uy(function(e){return By.test(e)||e.charCodeAt(0)===111&&e.charCodeAt(1)===110&&e.charCodeAt(2)<91}),oc=Ms.exports,Wy={childContextTypes:!0,contextType:!0,contextTypes:!0,defaultProps:!0,displayName:!0,getDefaultProps:!0,getDerivedStateFromError:!0,getDerivedStateFromProps:!0,mixins:!0,propTypes:!0,type:!0},Hy={name:!0,length:!0,prototype:!0,caller:!0,callee:!0,arguments:!0,arity:!0},Zy={$$typeof:!0,render:!0,defaultProps:!0,displayName:!0,propTypes:!0},Eh={$$typeof:!0,compare:!0,defaultProps:!0,displayName:!0,propTypes:!0,type:!0},ic={};ic[oc.ForwardRef]=Zy;ic[oc.Memo]=Eh;function Ad(e){return oc.isMemo(e)?Eh:ic[e.$$typeof]||Wy}var Qy=Object.defineProperty,Yy=Object.getOwnPropertyNames,Rd=Object.getOwnPropertySymbols,Gy=Object.getOwnPropertyDescriptor,Ky=Object.getPrototypeOf,Nd=Object.prototype;function Th(e,t,n){if(typeof t!="string"){if(Nd){var r=Ky(t);r&&r!==Nd&&Th(e,r,n)}var o=Yy(t);Rd&&(o=o.concat(Rd(t)));for(var i=Ad(e),s=Ad(t),l=0;l<o.length;++l){var a=o[l];if(!Hy[a]&&!(n&&n[a])&&!(s&&s[a])&&!(i&&i[a])){var u=Gy(t,a);try{Qy(e,a,u)}catch{}}}}return e}var Xy=Th;function Bt(){return(Bt=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e}).apply(this,arguments)}var Fd=function(e,t){for(var n=[e[0]],r=0,o=t.length;r<o;r+=1)n.push(t[r],e[r+1]);return n},Pa=function(e){return e!==null&&typeof e=="object"&&(e.toString?e.toString():Object.prototype.toString.call(e))==="[object Object]"&&!Ms.exports.typeOf(e)},ns=Object.freeze([]),$n=Object.freeze({});function Io(e){return typeof e=="function"}function Ld(e){return e.displayName||e.name||"Component"}function sc(e){return e&&typeof e.styledComponentId=="string"}var Vr=typeof process<"u"&&(process.env.REACT_APP_SC_ATTR||process.env.SC_ATTR)||"data-styled",lc=typeof window<"u"&&"HTMLElement"in window,qy=Boolean(typeof SC_DISABLE_SPEEDY=="boolean"?SC_DISABLE_SPEEDY:typeof process<"u"&&process.env.REACT_APP_SC_DISABLE_SPEEDY!==void 0&&process.env.REACT_APP_SC_DISABLE_SPEEDY!==""?process.env.REACT_APP_SC_DISABLE_SPEEDY!=="false"&&process.env.REACT_APP_SC_DISABLE_SPEEDY:typeof process<"u"&&process.env.SC_DISABLE_SPEEDY!==void 0&&process.env.SC_DISABLE_SPEEDY!==""?process.env.SC_DISABLE_SPEEDY!=="false"&&process.env.SC_DISABLE_SPEEDY:!1),Jy={};function Zo(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];throw new Error("An error occurred. See https://git.io/JUIaE#"+e+" for more information."+(n.length>0?" Args: "+n.join(", "):""))}var ev=function(){function e(n){this.groupSizes=new Uint32Array(512),this.length=512,this.tag=n}var t=e.prototype;return t.indexOfGroup=function(n){for(var r=0,o=0;o<n;o++)r+=this.groupSizes[o];return r},t.insertRules=function(n,r){if(n>=this.groupSizes.length){for(var o=this.groupSizes,i=o.length,s=i;n>=s;)(s<<=1)<0&&Zo(16,""+n);this.groupSizes=new Uint32Array(s),this.groupSizes.set(o),this.length=s;for(var l=i;l<s;l++)this.groupSizes[l]=0}for(var a=this.indexOfGroup(n+1),u=0,c=r.length;u<c;u++)this.tag.insertRule(a,r[u])&&(this.groupSizes[n]++,a++)},t.clearGroup=function(n){if(n<this.length){var r=this.groupSizes[n],o=this.indexOfGroup(n),i=o+r;this.groupSizes[n]=0;for(var s=o;s<i;s++)this.tag.deleteRule(o)}},t.getGroup=function(n){var r="";if(n>=this.length||this.groupSizes[n]===0)return r;for(var o=this.groupSizes[n],i=this.indexOfGroup(n),s=i+o,l=i;l<s;l++)r+=this.tag.getRule(l)+`/*!sc*/
`;return r},e}(),$i=new Map,rs=new Map,wo=1,pi=function(e){if($i.has(e))return $i.get(e);for(;rs.has(wo);)wo++;var t=wo++;return $i.set(e,t),rs.set(t,e),t},tv=function(e){return rs.get(e)},nv=function(e,t){t>=wo&&(wo=t+1),$i.set(e,t),rs.set(t,e)},rv="style["+Vr+'][data-styled-version="5.3.6"]',ov=new RegExp("^"+Vr+'\\.g(\\d+)\\[id="([\\w\\d-]+)"\\].*?"([^"]*)'),iv=function(e,t,n){for(var r,o=n.split(","),i=0,s=o.length;i<s;i++)(r=o[i])&&e.registerName(t,r)},sv=function(e,t){for(var n=(t.textContent||"").split(`/*!sc*/
`),r=[],o=0,i=n.length;o<i;o++){var s=n[o].trim();if(s){var l=s.match(ov);if(l){var a=0|parseInt(l[1],10),u=l[2];a!==0&&(nv(u,a),iv(e,u,l[3]),e.getTag().insertRules(a,r)),r.length=0}else r.push(s)}}},lv=function(){return typeof __webpack_nonce__<"u"?__webpack_nonce__:null},bh=function(e){var t=document.head,n=e||t,r=document.createElement("style"),o=function(l){for(var a=l.childNodes,u=a.length;u>=0;u--){var c=a[u];if(c&&c.nodeType===1&&c.hasAttribute(Vr))return c}}(n),i=o!==void 0?o.nextSibling:null;r.setAttribute(Vr,"active"),r.setAttribute("data-styled-version","5.3.6");var s=lv();return s&&r.setAttribute("nonce",s),n.insertBefore(r,i),r},av=function(){function e(n){var r=this.element=bh(n);r.appendChild(document.createTextNode("")),this.sheet=function(o){if(o.sheet)return o.sheet;for(var i=document.styleSheets,s=0,l=i.length;s<l;s++){var a=i[s];if(a.ownerNode===o)return a}Zo(17)}(r),this.length=0}var t=e.prototype;return t.insertRule=function(n,r){try{return this.sheet.insertRule(r,n),this.length++,!0}catch{return!1}},t.deleteRule=function(n){this.sheet.deleteRule(n),this.length--},t.getRule=function(n){var r=this.sheet.cssRules[n];return r!==void 0&&typeof r.cssText=="string"?r.cssText:""},e}(),uv=function(){function e(n){var r=this.element=bh(n);this.nodes=r.childNodes,this.length=0}var t=e.prototype;return t.insertRule=function(n,r){if(n<=this.length&&n>=0){var o=document.createTextNode(r),i=this.nodes[n];return this.element.insertBefore(o,i||null),this.length++,!0}return!1},t.deleteRule=function(n){this.element.removeChild(this.nodes[n]),this.length--},t.getRule=function(n){return n<this.length?this.nodes[n].textContent:""},e}(),cv=function(){function e(n){this.rules=[],this.length=0}var t=e.prototype;return t.insertRule=function(n,r){return n<=this.length&&(this.rules.splice(n,0,r),this.length++,!0)},t.deleteRule=function(n){this.rules.splice(n,1),this.length--},t.getRule=function(n){return n<this.length?this.rules[n]:""},e}(),Md=lc,dv={isServer:!lc,useCSSOMInjection:!qy},os=function(){function e(n,r,o){n===void 0&&(n=$n),r===void 0&&(r={}),this.options=Bt({},dv,{},n),this.gs=r,this.names=new Map(o),this.server=!!n.isServer,!this.server&&lc&&Md&&(Md=!1,function(i){for(var s=document.querySelectorAll(rv),l=0,a=s.length;l<a;l++){var u=s[l];u&&u.getAttribute(Vr)!=="active"&&(sv(i,u),u.parentNode&&u.parentNode.removeChild(u))}}(this))}e.registerId=function(n){return pi(n)};var t=e.prototype;return t.reconstructWithOptions=function(n,r){return r===void 0&&(r=!0),new e(Bt({},this.options,{},n),this.gs,r&&this.names||void 0)},t.allocateGSInstance=function(n){return this.gs[n]=(this.gs[n]||0)+1},t.getTag=function(){return this.tag||(this.tag=(o=(r=this.options).isServer,i=r.useCSSOMInjection,s=r.target,n=o?new cv(s):i?new av(s):new uv(s),new ev(n)));var n,r,o,i,s},t.hasNameForId=function(n,r){return this.names.has(n)&&this.names.get(n).has(r)},t.registerName=function(n,r){if(pi(n),this.names.has(n))this.names.get(n).add(r);else{var o=new Set;o.add(r),this.names.set(n,o)}},t.insertRules=function(n,r,o){this.registerName(n,r),this.getTag().insertRules(pi(n),o)},t.clearNames=function(n){this.names.has(n)&&this.names.get(n).clear()},t.clearRules=function(n){this.getTag().clearGroup(pi(n)),this.clearNames(n)},t.clearTag=function(){this.tag=void 0},t.toString=function(){return function(n){for(var r=n.getTag(),o=r.length,i="",s=0;s<o;s++){var l=tv(s);if(l!==void 0){var a=n.names.get(l),u=r.getGroup(s);if(a&&u&&a.size){var c=Vr+".g"+s+'[id="'+l+'"]',d="";a!==void 0&&a.forEach(function(p){p.length>0&&(d+=p+",")}),i+=""+u+c+'{content:"'+d+`"}/*!sc*/
`}}}return i}(this)},e}(),fv=/(a)(d)/gi,Od=function(e){return String.fromCharCode(e+(e>25?39:97))};function Aa(e){var t,n="";for(t=Math.abs(e);t>52;t=t/52|0)n=Od(t%52)+n;return(Od(t%52)+n).replace(fv,"$1-$2")}var kr=function(e,t){for(var n=t.length;n;)e=33*e^t.charCodeAt(--n);return e},$h=function(e){return kr(5381,e)};function Ph(e){for(var t=0;t<e.length;t+=1){var n=e[t];if(Io(n)&&!sc(n))return!1}return!0}var pv=$h("5.3.6"),hv=function(){function e(t,n,r){this.rules=t,this.staticRulesId="",this.isStatic=(r===void 0||r.isStatic)&&Ph(t),this.componentId=n,this.baseHash=kr(pv,n),this.baseStyle=r,os.registerId(n)}return e.prototype.generateAndInjectStyles=function(t,n,r){var o=this.componentId,i=[];if(this.baseStyle&&i.push(this.baseStyle.generateAndInjectStyles(t,n,r)),this.isStatic&&!r.hash)if(this.staticRulesId&&n.hasNameForId(o,this.staticRulesId))i.push(this.staticRulesId);else{var s=er(this.rules,t,n,r).join(""),l=Aa(kr(this.baseHash,s)>>>0);if(!n.hasNameForId(o,l)){var a=r(s,"."+l,void 0,o);n.insertRules(o,l,a)}i.push(l),this.staticRulesId=l}else{for(var u=this.rules.length,c=kr(this.baseHash,r.hash),d="",p=0;p<u;p++){var C=this.rules[p];if(typeof C=="string")d+=C;else if(C){var S=er(C,t,n,r),E=Array.isArray(S)?S.join(""):S;c=kr(c,E+p),d+=E}}if(d){var M=Aa(c>>>0);if(!n.hasNameForId(o,M)){var h=r(d,"."+M,void 0,o);n.insertRules(o,M,h)}i.push(M)}}return i.join(" ")},e}(),mv=/^\s*\/\/.*$/gm,gv=[":","[",".","#"];function yv(e){var t,n,r,o,i=e===void 0?$n:e,s=i.options,l=s===void 0?$n:s,a=i.plugins,u=a===void 0?ns:a,c=new jy(l),d=[],p=function(E){function M(h){if(h)try{E(h+"}")}catch{}}return function(h,f,g,x,$,z,D,I,te,K){switch(h){case 1:if(te===0&&f.charCodeAt(0)===64)return E(f+";"),"";break;case 2:if(I===0)return f+"/*|*/";break;case 3:switch(I){case 102:case 112:return E(g[0]+f),"";default:return f+(K===0?"/*|*/":"")}case-2:f.split("/*|*/}").forEach(M)}}}(function(E){d.push(E)}),C=function(E,M,h){return M===0&&gv.indexOf(h[n.length])!==-1||h.match(o)?E:"."+t};function S(E,M,h,f){f===void 0&&(f="&");var g=E.replace(mv,""),x=M&&h?h+" "+M+" { "+g+" }":g;return t=f,n=M,r=new RegExp("\\"+n+"\\b","g"),o=new RegExp("(\\"+n+"\\b){2,}"),c(h||!M?"":M,x)}return c.use([].concat(u,[function(E,M,h){E===2&&h.length&&h[0].lastIndexOf(n)>0&&(h[0]=h[0].replace(r,C))},p,function(E){if(E===-2){var M=d;return d=[],M}}])),S.hash=u.length?u.reduce(function(E,M){return M.name||Zo(15),kr(E,M.name)},5381).toString():"",S}var Ah=he.createContext();Ah.Consumer;var Rh=he.createContext(),vv=(Rh.Consumer,new os),Ra=yv();function Nh(){return v.exports.useContext(Ah)||vv}function Fh(){return v.exports.useContext(Rh)||Ra}var Lh=function(){function e(t,n){var r=this;this.inject=function(o,i){i===void 0&&(i=Ra);var s=r.name+i.hash;o.hasNameForId(r.id,s)||o.insertRules(r.id,s,i(r.rules,s,"@keyframes"))},this.toString=function(){return Zo(12,String(r.name))},this.name=t,this.id="sc-keyframes-"+t,this.rules=n}return e.prototype.getName=function(t){return t===void 0&&(t=Ra),this.name+t.hash},e}(),wv=/([A-Z])/,xv=/([A-Z])/g,kv=/^ms-/,Sv=function(e){return"-"+e.toLowerCase()};function zd(e){return wv.test(e)?e.replace(xv,Sv).replace(kv,"-ms-"):e}var Id=function(e){return e==null||e===!1||e===""};function er(e,t,n,r){if(Array.isArray(e)){for(var o,i=[],s=0,l=e.length;s<l;s+=1)(o=er(e[s],t,n,r))!==""&&(Array.isArray(o)?i.push.apply(i,o):i.push(o));return i}if(Id(e))return"";if(sc(e))return"."+e.styledComponentId;if(Io(e)){if(typeof(u=e)!="function"||u.prototype&&u.prototype.isReactComponent||!t)return e;var a=e(t);return er(a,t,n,r)}var u;return e instanceof Lh?n?(e.inject(n,r),e.getName(r)):e:Pa(e)?function c(d,p){var C,S,E=[];for(var M in d)d.hasOwnProperty(M)&&!Id(d[M])&&(Array.isArray(d[M])&&d[M].isCss||Io(d[M])?E.push(zd(M)+":",d[M],";"):Pa(d[M])?E.push.apply(E,c(d[M],M)):E.push(zd(M)+": "+(C=M,(S=d[M])==null||typeof S=="boolean"||S===""?"":typeof S!="number"||S===0||C in Vy?String(S).trim():S+"px")+";"));return p?[p+" {"].concat(E,["}"]):E}(e):e.toString()}var Dd=function(e){return Array.isArray(e)&&(e.isCss=!0),e};function It(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];return Io(e)||Pa(e)?Dd(er(Fd(ns,[e].concat(n)))):n.length===0&&e.length===1&&typeof e[0]=="string"?e:Dd(er(Fd(e,n)))}var Mh=function(e,t,n){return n===void 0&&(n=$n),e.theme!==n.theme&&e.theme||t||n.theme},_v=/[!"#$%&'()*+,./:;<=>?@[\\\]^`{|}~-]+/g,Cv=/(^-|-$)/g;function Cl(e){return e.replace(_v,"-").replace(Cv,"")}var ac=function(e){return Aa($h(e)>>>0)};function hi(e){return typeof e=="string"&&!0}var Na=function(e){return typeof e=="function"||typeof e=="object"&&e!==null&&!Array.isArray(e)},Ev=function(e){return e!=="__proto__"&&e!=="constructor"&&e!=="prototype"};function Tv(e,t,n){var r=e[n];Na(t)&&Na(r)?Oh(r,t):e[n]=t}function Oh(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];for(var o=0,i=n;o<i.length;o++){var s=i[o];if(Na(s))for(var l in s)Ev(l)&&Tv(e,s[l],l)}return e}var uc=he.createContext();uc.Consumer;var El={};function zh(e,t,n){var r=sc(e),o=!hi(e),i=t.attrs,s=i===void 0?ns:i,l=t.componentId,a=l===void 0?function(f,g){var x=typeof f!="string"?"sc":Cl(f);El[x]=(El[x]||0)+1;var $=x+"-"+ac("5.3.6"+x+El[x]);return g?g+"-"+$:$}(t.displayName,t.parentComponentId):l,u=t.displayName,c=u===void 0?function(f){return hi(f)?"styled."+f:"Styled("+Ld(f)+")"}(e):u,d=t.displayName&&t.componentId?Cl(t.displayName)+"-"+t.componentId:t.componentId||a,p=r&&e.attrs?Array.prototype.concat(e.attrs,s).filter(Boolean):s,C=t.shouldForwardProp;r&&e.shouldForwardProp&&(C=t.shouldForwardProp?function(f,g,x){return e.shouldForwardProp(f,g,x)&&t.shouldForwardProp(f,g,x)}:e.shouldForwardProp);var S,E=new hv(n,d,r?e.componentStyle:void 0),M=E.isStatic&&s.length===0,h=function(f,g){return function(x,$,z,D){var I=x.attrs,te=x.componentStyle,K=x.defaultProps,Z=x.foldedComponentIds,Y=x.shouldForwardProp,ae=x.styledComponentId,ve=x.target,we=function(X,w,ie){X===void 0&&(X=$n);var L=Bt({},w,{theme:X}),Te={};return ie.forEach(function(fe){var m,y,k,N=fe;for(m in Io(N)&&(N=N(L)),N)L[m]=Te[m]=m==="className"?(y=Te[m],k=N[m],y&&k?y+" "+k:y||k):N[m]}),[L,Te]}(Mh($,v.exports.useContext(uc),K)||$n,$,I),He=we[0],je=we[1],F=function(X,w,ie,L){var Te=Nh(),fe=Fh(),m=w?X.generateAndInjectStyles($n,Te,fe):X.generateAndInjectStyles(ie,Te,fe);return m}(te,D,He),G=z,q=je.$as||$.$as||je.as||$.as||ve,me=hi(q),O=je!==$?Bt({},$,{},je):$,V={};for(var U in O)U[0]!=="$"&&U!=="as"&&(U==="forwardedAs"?V.as=O[U]:(Y?Y(U,Pd,q):!me||Pd(U))&&(V[U]=O[U]));return $.style&&je.style!==$.style&&(V.style=Bt({},$.style,{},je.style)),V.className=Array.prototype.concat(Z,ae,F!==ae?F:null,$.className,je.className).filter(Boolean).join(" "),V.ref=G,v.exports.createElement(q,V)}(S,f,g,M)};return h.displayName=c,(S=he.forwardRef(h)).attrs=p,S.componentStyle=E,S.displayName=c,S.shouldForwardProp=C,S.foldedComponentIds=r?Array.prototype.concat(e.foldedComponentIds,e.styledComponentId):ns,S.styledComponentId=d,S.target=r?e.target:e,S.withComponent=function(f){var g=t.componentId,x=function(z,D){if(z==null)return{};var I,te,K={},Z=Object.keys(z);for(te=0;te<Z.length;te++)I=Z[te],D.indexOf(I)>=0||(K[I]=z[I]);return K}(t,["componentId"]),$=g&&g+"-"+(hi(f)?f:Cl(Ld(f)));return zh(f,Bt({},x,{attrs:p,componentId:$}),n)},Object.defineProperty(S,"defaultProps",{get:function(){return this._foldedDefaultProps},set:function(f){this._foldedDefaultProps=r?Oh({},e.defaultProps,f):f}}),S.toString=function(){return"."+S.styledComponentId},o&&Xy(S,e,{attrs:!0,componentStyle:!0,displayName:!0,foldedComponentIds:!0,shouldForwardProp:!0,styledComponentId:!0,target:!0,withComponent:!0}),S}var Fa=function(e){return function t(n,r,o){if(o===void 0&&(o=$n),!Ms.exports.isValidElementType(r))return Zo(1,String(r));var i=function(){return n(r,o,It.apply(void 0,arguments))};return i.withConfig=function(s){return t(n,r,Bt({},o,{},s))},i.attrs=function(s){return t(n,r,Bt({},o,{attrs:Array.prototype.concat(o.attrs,s).filter(Boolean)}))},i}(zh,e)};["a","abbr","address","area","article","aside","audio","b","base","bdi","bdo","big","blockquote","body","br","button","canvas","caption","cite","code","col","colgroup","data","datalist","dd","del","details","dfn","dialog","div","dl","dt","em","embed","fieldset","figcaption","figure","footer","form","h1","h2","h3","h4","h5","h6","head","header","hgroup","hr","html","i","iframe","img","input","ins","kbd","keygen","label","legend","li","link","main","map","mark","marquee","menu","menuitem","meta","meter","nav","noscript","object","ol","optgroup","option","output","p","param","picture","pre","progress","q","rp","rt","ruby","s","samp","script","section","select","small","source","span","strong","style","sub","summary","sup","table","tbody","td","textarea","tfoot","th","thead","time","title","tr","track","u","ul","var","video","wbr","circle","clipPath","defs","ellipse","foreignObject","g","image","line","linearGradient","marker","mask","path","pattern","polygon","polyline","radialGradient","rect","stop","svg","text","textPath","tspan"].forEach(function(e){Fa[e]=Fa(e)});var bv=function(){function e(n,r){this.rules=n,this.componentId=r,this.isStatic=Ph(n),os.registerId(this.componentId+1)}var t=e.prototype;return t.createStyles=function(n,r,o,i){var s=i(er(this.rules,r,o,i).join(""),""),l=this.componentId+n;o.insertRules(l,l,s)},t.removeStyles=function(n,r){r.clearRules(this.componentId+n)},t.renderStyles=function(n,r,o,i){n>2&&os.registerId(this.componentId+n),this.removeStyles(n,o),this.createStyles(n,r,o,i)},e}();function $v(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];var o=It.apply(void 0,[e].concat(n)),i="sc-global-"+ac(JSON.stringify(o)),s=new bv(o,i);function l(u){var c=Nh(),d=Fh(),p=v.exports.useContext(uc),C=v.exports.useRef(c.allocateGSInstance(i)).current;return c.server&&a(C,u,c,p,d),v.exports.useLayoutEffect(function(){if(!c.server)return a(C,u,c,p,d),function(){return s.removeStyles(C,c)}},[C,u,c,p,d]),null}function a(u,c,d,p,C){if(s.isStatic)s.renderStyles(u,Jy,d,C);else{var S=Bt({},c,{theme:Mh(c,p,l.defaultProps)});s.renderStyles(u,S,d,C)}}return he.memo(l)}function Yt(e){for(var t=arguments.length,n=new Array(t>1?t-1:0),r=1;r<t;r++)n[r-1]=arguments[r];var o=It.apply(void 0,[e].concat(n)).join(""),i=ac(o);return new Lh(i,o)}const T=Fa,Pv=Yt`
  from { opacity: 0 }
  to { opacity: 1 }
`,Av=Yt`
  from { opacity: 1 }
  to { opacity: 0 }
`,Rv=T.li` 
  min-height: 3.875rem;

  padding: 0.875rem 1rem;

  display: flex;
  gap: 1rem;
  align-items: center; 

  background: #2C2C2C;
  border-radius: 1rem;

  ${({fadeOut:e})=>e?It` 
      animation-name: ${Av};
      animation-duration: 300ms; 
      animation-fill-mode: forwards; 
    `:It`
      animation-name: ${Pv};
      animation-duration: 300ms; 
      animation-fill-mode: forwards; 
    `}
`,jd=T.span`
  font-family: 'Roboto Mono';
  font-style: normal;
  font-weight: 700;
  font-size: 1.375rem;
  line-height: 100%;

  color: #FFFFFF;
`,Nv=T.img` 
  width: 2.125rem;
  height: 2.125rem;
`,Fv="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACIAAAAiCAYAAAA6RwvCAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMfSURBVHgB7VVJaxRBFP5edU9myyJjMklIcMF4CDkYomCSS4REUXC9ixdPXsQ/oCB4EE+e9KQJouSoEAQhuCASwUNAI3jQSAQly0wWSZy1u56vJ4uTmcymiSLMB9Pd9dXXr75Xr/oNUEYZZfxHWKpDQ7TWPOQ8Uy4Ry1y41tfgk7sPkUUKYzHFt8AdC3sa8r1bDAyXvU3DHpRHjwVvV24jQfeeGCdHRFAlrj4L1W9FvQ9MX+yuzPbJ2IVNAjPmcxqJN6IVlnotO1Ozqpc9GJdrC7YAeUuTrEM7a+yAUmdkfFZoI0O2YLA+nU5Y8p4CXWKiU9gMI+mYqUNlDRvDTNyZaYRAj9IJLTGJuEcy2YXiwWYxqiqgQ0zs3DgET2Qwkhy3L+fIE8Q0gEIuCPNZRpySRBpcB0ytmxJkj1RNY8Ybwsv4dt0LRYNyUPal6zXRl+zQ9D0ViTHhDuurKAJZpUnWGcds4ocSxC3DHyK542b7uny+k9wIX9xySkGHUQQU87OKMPcWpc0kLHD3igkHfknrYgJqKFaNvTSJiMyfE/4d1mXDC04ZfjGp8bgkdB9FIsuIImrN5KSG+8ljDMhmG5UhTInRW+sVNCcGu+T+IjViuukJcYuUtB+/YyRZb/Yy81Fi/pA0dJChz6+ZYe6OB82+ZWMUXyaRlOs4y6w/iRj+AGuHNVHv6rTZviePfk2YrTSxFLeMaUlvVRLlpBVZXh+LqcNFmCOtT1QQFhb9MMwEB9TKPEpEKp7TRdlST+WxcYWXDcCoBN0tZQnI6LENvuIPY9SZjATQbBjqoyzolt8n6SXfRNMk0ZyuG1da91TM4g1KAM0GUO031Yik0ZZTZesjnjkMp1OxIC4Qq2tiJLBGMiwifbkihBuU6m3Fw6xUxnFJvy2fSKozlcl5ZnA7Xq9fwVa9smiNUw5F+rkrhLelmkgZAemThTo924huxLunMSZrjmEToOQLOFhIJOek5AxLNiJ1DRYSef6Skfx/fNJMogo2ttwI8ZCzGHKYkPkn3mqEsMUgboY3mkCHS2fvjPSSiMuL9/R148NaRhll/Ev8BPJaNmWo7bcAAAAAAElFTkSuQmCC";function Lv({id:e,killer:t,victim:n}){const{removeNotify:r}=Ly(),[o,i]=v.exports.useState(!1);return v.exports.useEffect(()=>{const s=setTimeout(()=>{i(!0)},8e3);return()=>clearTimeout(s)},[]),ee(Rv,{fadeOut:o,onAnimationEnd:()=>o&&r({id:e,killer:t,victim:n}),children:[_(jd,{children:t}),_(Nv,{src:Fv,alt:""}),_(jd,{children:n})]})}const Mv=T.ol` 
  position: absolute; 
  top: 12.5rem;
  right: 1.5rem;

  display: flex; 
  flex-direction: column;
  align-items: flex-end; 
  gap: 1rem;
`;function Ov(){const[e,t]=v.exports.useState([]),[n]=Fy({duration:300}),r=s=>{t(l=>[...l,s])},o=s=>{t(l=>l.filter(a=>s.id!==a.id))},i=({data:s})=>{switch(s.action){case"killfeed":r(s.notify);break}};return v.exports.useEffect(()=>(window.addEventListener("message",i),()=>{window.removeEventListener("message",i)})),_(Mv,{ref:n,children:_(_h.Provider,{value:{removeNotify:o},children:e.map(s=>_(Lv,{...s},s.id))})})}async function Fe(e,t,n){const r={method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(t)},o=`https://${GetParentResourceName()}/${e}`;try{return await(await fetch(o,r)).json()}catch{throw new Error(o)}}const zv=T.button` 
  padding: 0.75rem 1.5rem;

  border-radius: 0.75rem;

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1rem;
  line-height: 90.19%;

  letter-spacing: 0.03em;

  ${({active:e})=>It`
    background: ${e?"#FF4E4E":"#2C2C2C"};
    box-shadow: ${e?"0 0.25rem 0.25rem rgba(187, 58, 58, 0.25)":"0 0.25rem 0.25rem rgba(0, 0, 0, 0.25)"};
    color: ${e?"#FFFFFF":"#AEAEAE"};
  `}

  cursor: pointer;

  :hover {
    color: #FFFFFF;
  }
`,Iv=T.div`
  display: flex; 
  flex-direction: column; 
  justify-content: center;
  gap: 0.125rem;

  margin-right: auto;
`,Dv=T.h1` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 3rem;
  line-height: 2.5rem;

  letter-spacing: 0.03em;

  background: linear-gradient(90deg, #FF4E4E 0%, #990F0F 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  -webkit-text-fill-color: transparent;

  text-shadow: 0 0 0.25rem rgba(187, 58, 58, 0.75);
`,jv=T.h1` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 3rem;
  line-height: 2.5rem;

  letter-spacing: 0.03em;

  color: #FFFFFF;

  text-shadow: 0 0 0.25rem rgba(255, 255, 255, 0.75);
`;function Ih(){return ee(Iv,{children:[_(Dv,{children:"LATE"}),_(jv,{children:"GAME"})]})}const Vv=T.div` 
  width: 100%; 
  height: 18.5rem;

  overflow: auto; 

  display: flex; 
  gap: 1.5rem; 
  flex-wrap: wrap; 

  ::-webkit-scrollbar {
    width: 0.5rem;
  }

  ::-webkit-scrollbar-track {
    width: 0.5rem;
    border-radius: 0.25rem;

    background: #1C1C1C;
  }

  ::-webkit-scrollbar-thumb {
    border-radius: 0.25rem;

    background: #474747;
  }

  ::-webkit-scrollbar-thumb:hover {
    cursor: pointer;
  } 
`;function Zs({cards:e}){return _(Vv,{children:e})}function Pt(){return Pt=Object.assign?Object.assign.bind():function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},Pt.apply(this,arguments)}function Uv(e,t){const n=v.exports.createContext(t);function r(i){const{children:s,...l}=i,a=v.exports.useMemo(()=>l,Object.values(l));return v.exports.createElement(n.Provider,{value:a},s)}function o(i){const s=v.exports.useContext(n);if(s)return s;if(t!==void 0)return t;throw new Error(`\`${i}\` must be used within \`${e}\``)}return r.displayName=e+"Provider",[r,o]}function Dh(e,t=[]){let n=[];function r(i,s){const l=v.exports.createContext(s),a=n.length;n=[...n,s];function u(d){const{scope:p,children:C,...S}=d,E=(p==null?void 0:p[e][a])||l,M=v.exports.useMemo(()=>S,Object.values(S));return v.exports.createElement(E.Provider,{value:M},C)}function c(d,p){const C=(p==null?void 0:p[e][a])||l,S=v.exports.useContext(C);if(S)return S;if(s!==void 0)return s;throw new Error(`\`${d}\` must be used within \`${i}\``)}return u.displayName=i+"Provider",[u,c]}const o=()=>{const i=n.map(s=>v.exports.createContext(s));return function(l){const a=(l==null?void 0:l[e])||i;return v.exports.useMemo(()=>({[`__scope${e}`]:{...l,[e]:a}}),[l,a])}};return o.scopeName=e,[r,Bv(o,...t)]}function Bv(...e){const t=e[0];if(e.length===1)return t;const n=()=>{const r=e.map(o=>({useScope:o(),scopeName:o.scopeName}));return function(i){const s=r.reduce((l,{useScope:a,scopeName:u})=>{const d=a(i)[`__scope${u}`];return{...l,...d}},{});return v.exports.useMemo(()=>({[`__scope${t.scopeName}`]:s}),[s])}};return n.scopeName=t.scopeName,n}function Wv(e,t){typeof e=="function"?e(t):e!=null&&(e.current=t)}function cc(...e){return t=>e.forEach(n=>Wv(n,t))}function Hv(...e){return v.exports.useCallback(cc(...e),e)}const jh=v.exports.forwardRef((e,t)=>{const{children:n,...r}=e,o=v.exports.Children.toArray(n),i=o.find(Qv);if(i){const s=i.props.children,l=o.map(a=>a===i?v.exports.Children.count(s)>1?v.exports.Children.only(null):v.exports.isValidElement(s)?s.props.children:null:a);return v.exports.createElement(La,Pt({},r,{ref:t}),v.exports.isValidElement(s)?v.exports.cloneElement(s,void 0,l):null)}return v.exports.createElement(La,Pt({},r,{ref:t}),n)});jh.displayName="Slot";const La=v.exports.forwardRef((e,t)=>{const{children:n,...r}=e;return v.exports.isValidElement(n)?v.exports.cloneElement(n,{...Yv(r,n.props),ref:cc(t,n.ref)}):v.exports.Children.count(n)>1?v.exports.Children.only(null):null});La.displayName="SlotClone";const Zv=({children:e})=>v.exports.createElement(v.exports.Fragment,null,e);function Qv(e){return v.exports.isValidElement(e)&&e.type===Zv}function Yv(e,t){const n={...t};for(const r in t){const o=e[r],i=t[r];/^on[A-Z]/.test(r)?o&&i?n[r]=(...l)=>{i(...l),o(...l)}:o&&(n[r]=o):r==="style"?n[r]={...o,...i}:r==="className"&&(n[r]=[o,i].filter(Boolean).join(" "))}return{...e,...n}}const Gv=["a","button","div","h2","h3","img","label","li","nav","ol","p","span","svg","ul"],Kv=Gv.reduce((e,t)=>{const n=v.exports.forwardRef((r,o)=>{const{asChild:i,...s}=r,l=i?jh:t;return v.exports.useEffect(()=>{window[Symbol.for("radix-ui")]=!0},[]),v.exports.createElement(l,Pt({},s,{ref:o}))});return n.displayName=`Primitive.${t}`,{...e,[t]:n}},{}),Vh="Progress",Qs=100,[Xv,N2]=Dh(Vh),[qv,F2]=Xv(Vh),Uh=v.exports.forwardRef((e,t)=>{const{__scopeProgress:n,value:r,max:o,getValueLabel:i=Jv,...s}=e,l=Ma(o)?o:Qs,a=Bh(r,l)?r:null,u=is(a)?i(a,l):void 0;return v.exports.createElement(qv,{scope:n,value:a,max:l},v.exports.createElement(Kv.div,Pt({"aria-valuemax":l,"aria-valuemin":0,"aria-valuenow":is(a)?a:void 0,"aria-valuetext":u,role:"progressbar","data-state":e1(a,l),"data-value":a!=null?a:void 0,"data-max":l},s,{ref:t})))});Uh.propTypes={max(e,t,n){const r=e[t],o=String(r);return r&&!Ma(r)?new Error(t1(o,n)):null},value(e,t,n){const r=e[t],o=String(r),i=Ma(e.max)?e.max:Qs;return r!=null&&!Bh(r,i)?new Error(n1(o,n)):null}};function Jv(e,t){return`${Math.round(e/t*100)}%`}function e1(e,t){return e==null?"indeterminate":e===t?"complete":"loading"}function is(e){return typeof e=="number"}function Ma(e){return is(e)&&!isNaN(e)&&e>0}function Bh(e,t){return is(e)&&!isNaN(e)&&e<=t&&e>=0}function t1(e,t){return`Invalid prop \`max\` of value \`${e}\` supplied to \`${t}\`. Only numbers greater than 0 are valid max values. Defaulting to \`${Qs}\`.`}function n1(e,t){return`Invalid prop \`value\` of value \`${e}\` supplied to \`${t}\`. The \`value\` prop must be:
  - a positive number
  - less than the value passed to \`max\` (or ${Qs} if no \`max\` prop is set)
  - \`null\` if the progress is indeterminate.

Defaulting to \`null\`.`}const Yr=Uh,Wh=""+new URL("user.4914fff1.svg",import.meta.url).href,r1=T.section` 
  padding: 0.75rem 0;
  
  border-top: 0.0625rem solid #2C2C2C;
  border-bottom: 0.0625rem solid #2C2C2C;

  display: flex; 
  gap: 0.375rem; 

  ::before {
    content: ''; 

    width: 1.375rem; 
    height: 1.375rem; 

    background: url(${Wh}); 
    background-size: 100% 100%; 
    background-repeat: no-repeat; 
    background-position: center center; 
  }
`,o1=T.div` 
  display: flex;
  flex-direction: column; 
  align-items: center; 
  gap: 0.25rem;

  padding-top: 0.125rem;
`,i1=T(Yr)`
  background: #2C2C2C;
  border-radius: 0.5rem;

  width: 6.875rem;
  height: 0.5rem;

  padding: 0.0625rem; 

  display: flex; 
  align-items: center;
  justify-content: start; 

  overflow: hidden;
`,s1=T(Yr)`
  background: #D9D9D9;
  border-radius: 0.5rem;

  width: ${({progress:e})=>`${e}%`};
  height: 100%;

  transition: width 1s cubic-bezier(0.65, 0, 0.35, 1);
`,l1=T.h2` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  font-size: 0.5rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #AEAEAE;
`,Qo=v.exports.createContext({});function Ys(){return v.exports.useContext(Qo)}function a1({amount:e}){const[t,n]=v.exports.useState(0),{messages:r}=xt(),{limitMembers:o}=Ys();return v.exports.useEffect(()=>{const i=setTimeout(()=>{n(e/o*100)},200);return()=>clearTimeout(i)},[]),_(r1,{children:ee(o1,{children:[_(i1,{children:_(s1,{progress:t})}),ee(l1,{children:[e," ",r.amountOfTotal," ",o]})]})})}const u1=""+new URL("verified.5b3afc32.svg",import.meta.url).href,ss=T.h1` 
  max-width: 100%; 
  white-space: nowrap;
  
  font-family: 'Roboto Mono', monospace;
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 120%;
  
  text-transform: uppercase; 
  letter-spacing: 0.03em;

  color: #FFFFFF;

  display: flex;
  align-items: center; 
  gap: 0.5rem;

  ${({verified:e})=>e?It`
    ::after {
      content: '';

      width: 0.625rem;
      height: 0.625rem; 

      background: url(${u1}); 
      background-size: 100% 100%; 
      background-repeat: no-repeat; 
      background-position: center center; 
    }
  `:""}
`,c1=T.div` 
  width: 10.75rem;
  height: 8.875rem;

  background: #1C1C1C;
  border-radius: 0.5rem;

  padding: 0.75rem 0.25rem;

  display: flex; 
  flex-direction: column;
  align-items: center; 
`,d1=T.button` 
  background: #FF4E4E;
  border-radius: 0.25rem;

  padding: 0.375rem 1.5rem;

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 0.75rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #FFFFFF;

  margin-top: 0.75rem;

  cursor: pointer;
`,f1=T(ss)`
  padding-bottom: 0.75rem;
`;function Hh({name:e,members:t,verified:n,button:r}){return ee(c1,{children:[_(f1,{verified:n,children:e.slice(0,10)}),_(a1,{amount:t}),_(d1,{onClick:r.onClick,children:r.label})]})}const p1=e=>v.exports.createElement("svg",{style:{aspectRatio:1},viewBox:"0 0 16 16",fill:"none",xmlns:"http://www.w3.org/2000/svg",role:"img",...e},v.exports.createElement("path",{d:"M6.33331 10L6.33331 8",stroke:"white",strokeLinecap:"round"}),v.exports.createElement("path",{d:"M9.66669 10L9.66669 8",stroke:"white",strokeLinecap:"round"}),v.exports.createElement("path",{d:"M2 4.66669H14V4.66669C13.6904 4.66669 13.5356 4.66669 13.4056 4.6838C12.5081 4.80195 11.8019 5.50817 11.6838 6.40563C11.6667 6.5356 11.6667 6.69041 11.6667 7.00002V9.66669C11.6667 11.2304 11.6667 12.0123 11.2534 12.5509C11.147 12.6895 11.0229 12.8137 10.8842 12.9201C10.3456 13.3334 9.56372 13.3334 8 13.3334V13.3334C6.43628 13.3334 5.65443 13.3334 5.11581 12.9201C4.97715 12.8137 4.85303 12.6895 4.74663 12.5509C4.33333 12.0123 4.33333 11.2304 4.33333 9.66669V7.00002C4.33333 6.69041 4.33333 6.5356 4.31622 6.40563C4.19807 5.50817 3.49185 4.80195 2.59439 4.6838C2.46442 4.66669 2.30961 4.66669 2 4.66669V4.66669Z",stroke:"white",strokeLinecap:"round"}),v.exports.createElement("path",{d:"M6.33335 2.66683C6.33335 2.66683 6.66669 2 8.00002 2C9.33335 2 9.66669 2.66667 9.66669 2.66667",stroke:"white",strokeLinecap:"round"})),h1=e=>v.exports.createElement("svg",{style:{aspectRatio:1},viewBox:"0 0 8 8",fill:"none",xmlns:"http://www.w3.org/2000/svg",role:"img",...e},v.exports.createElement("path",{d:"M2.33331 2.3773V2.3773C2.33331 1.47444 3.13297 0.780894 4.02676 0.908578L4.52598 0.979895C5.94555 1.18269 6.99998 2.39846 6.99998 3.83244V4.16754C6.99998 5.60152 5.94555 6.81729 4.52598 7.02008L3.96146 7.10073C3.10214 7.22349 2.33331 6.55669 2.33331 5.68865V5.68865",stroke:"#FF4E4E"}),v.exports.createElement("path",{d:"M5.33331 4.00001L5.72375 3.68766L5.97363 4.00001L5.72375 4.31236L5.33331 4.00001ZM1.33331 4.50001C1.05717 4.50001 0.833313 4.27615 0.833313 4.00001C0.833313 3.72387 1.05717 3.50001 1.33331 3.50001V4.50001ZM4.39041 2.021L5.72375 3.68766L4.94288 4.31236L3.60955 2.64569L4.39041 2.021ZM5.72375 4.31236L4.39041 5.97902L3.60955 5.35433L4.94288 3.68766L5.72375 4.31236ZM5.33331 4.50001H1.33331V3.50001H5.33331V4.50001Z",fill:"#FF4E4E"})),m1=e=>v.exports.createElement("svg",{style:{aspectRatio:1},viewBox:"0 0 16 16",fill:"none",xmlns:"http://www.w3.org/2000/svg",role:"img",...e},v.exports.createElement("path",{d:"M4.66669 4.75463V4.75463C4.66669 3.731 4.66669 3.21918 4.83578 2.83452C5.07698 2.28582 5.55156 1.87421 6.12887 1.71303C6.53357 1.60004 7.04024 1.67242 8.05359 1.81719L9.05203 1.95982C11.3095 2.28232 12.4382 2.44356 13.1519 3.17824C13.2306 3.25923 13.3046 3.3446 13.3737 3.43394C14 4.24432 14 5.38452 14 7.6649V8.33512C14 10.6155 14 11.7557 13.3737 12.5661C13.3046 12.6554 13.2306 12.7408 13.1519 12.8218C12.4382 13.5565 11.3095 13.7177 9.05203 14.0402L7.92298 14.2015C7.0303 14.329 6.58396 14.3928 6.22385 14.311C5.57204 14.163 5.03725 13.6992 4.79856 13.0749C4.66669 12.7299 4.66669 12.2791 4.66669 11.3773V11.3773",stroke:"white"}),v.exports.createElement("path",{d:"M10.6667 7.99999L11.0571 7.68764L11.307 7.99999L11.0571 8.31234L10.6667 7.99999ZM2.66669 8.49999C2.39054 8.49999 2.16669 8.27613 2.16669 7.99999C2.16669 7.72385 2.39054 7.49999 2.66669 7.49999V8.49999ZM8.39045 4.35431L11.0571 7.68764L10.2763 8.31234L7.60959 4.979L8.39045 4.35431ZM11.0571 8.31234L8.39045 11.6457L7.60959 11.021L10.2763 7.68764L11.0571 8.31234ZM10.6667 8.49999H2.66669V7.49999H10.6667V8.49999Z",fill:"white"})),g1=e=>v.exports.createElement("svg",{style:{aspectRatio:"12 / 7"},viewBox:"0 0 12 7",fill:"none",xmlns:"http://www.w3.org/2000/svg",role:"img",...e},v.exports.createElement("path",{d:"M2 7L0 2.69231L2.5 5.38462L1.5 1.61538L3.5 4.84615V0.538462L5 4.84615L6 0L7 4.84615L8.5 0.538462V4.84615L10.5 1.61538L9.5 5.38462L12 2.69231L10.5 7C10.5 7 7.76801 6.43546 6 6.46154C4.42589 6.48476 2 7 2 7Z",fill:"#FFC700"})),Zh=e=>v.exports.createElement("svg",{style:{aspectRatio:1},viewBox:"0 0 24 24",fill:"none",xmlns:"http://www.w3.org/2000/svg",role:"img",...e},v.exports.createElement("path",{fillRule:"evenodd",clipRule:"evenodd",d:"M2 12C2 6.47715 6.47715 2 12 2C17.5228 2 22 6.47715 22 12C22 15.0141 20.6665 17.7167 18.5573 19.5501C18.0996 18.3251 17.306 17.2481 16.2613 16.4465C15.0388 15.5085 13.5409 15 12 15C10.4591 15 8.96118 15.5085 7.73867 16.4465C6.69405 17.2481 5.90038 18.3251 5.44269 19.5501C3.33349 17.7167 2 15.0141 2 12ZM16.8296 20.7059C16.8337 20.7212 16.8381 20.7363 16.8429 20.7512C15.4081 21.5469 13.757 22 12 22C10.243 22 8.59193 21.5469 7.15711 20.7512C7.16185 20.7363 7.16628 20.7212 7.17037 20.7059C7.45525 19.6427 8.08297 18.7033 8.95619 18.0332C9.82942 17.3632 10.8993 17 12 17C13.1007 17 14.1706 17.3632 15.0438 18.0332C15.917 18.7033 16.5448 19.6427 16.8296 20.7059ZM10 9C10 7.89543 10.8954 7 12 7C13.1046 7 14 7.89543 14 9C14 10.1046 13.1046 11 12 11C10.8954 11 10 10.1046 10 9ZM12 5C9.79086 5 8 6.79086 8 9C8 11.2091 9.79086 13 12 13C14.2091 13 16 11.2091 16 9C16 6.79086 14.2091 5 12 5Z",fill:"#D9D9D9"}),v.exports.createElement("rect",{x:2.5,y:2.5,width:19,height:19,rx:9.5,stroke:"#D9D9D9"})),y1=T(g1)`
  width: 0.75rem;
  height: 0.4375rem;
`,v1=T(h1)`
  width: 0.5rem;
  height: 0.5rem;

  cursor: pointer;
`,w1=T(p1)`
  width: 1rem;
  height: 1rem;

  cursor: pointer;
`,x1=T(m1)`
  width: 1rem;
  height: 1rem;

  cursor: pointer;
`,k1=T(Zh)`
  width: 1.5rem;
  height: 1.5rem;
`,S1=T.div`
  display: flex; 
  flex-direction: column-reverse; 
  align-items: center; 

  gap: 0.125rem;
`,_1=T.h3`
  font-family: 'Roboto Mono';
  font-style: normal;
  font-weight: 700;
  font-size: 0.5rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #D9D9D9;
`;function C1({id:e,group:t,updateCurrentTeam:n}){let r;const o=()=>{Fe("kickMember",{id:e}).then(({status:i})=>{i&&n()})};switch(t){case"KICKABLE":r=_(v1,{onClick:o});break;case"OWNER":r=_(y1,{});break}return ee(S1,{children:[ee(_1,{children:["#",e]}),_(k1,{}),r]})}const E1=T.section` 
  padding: 0.75rem 0;
  
  display: flex; 
  gap: 0.375rem; 

  ::before {
    content: ''; 

    width: 1.5rem; 
    height: 1.5rem; 

    background: url(${Wh}); 
    background-size: 100% 100%; 
    background-repeat: no-repeat; 
    background-position: center center; 
  }
`,T1=T.div` 
  display: flex;
  flex-direction: column; 
  align-items: center; 
  gap: 0.25rem;

  padding-top: 0.125rem;
`,b1=T(Yr)`
  background: #2C2C2C;
  border-radius: 0.5rem;

  width: 6.75rem;
  height: 0.5rem;

  padding: 0.0625rem; 

  display: flex; 
  align-items: center;
  justify-content: start; 

  overflow: hidden;
`,$1=T(Yr)`
  background: #D9D9D9;
  border-radius: 0.5rem;

  width: ${({progress:e})=>`${e}%`};
  height: 100%;

  transition: width 1s cubic-bezier(0.65, 0, 0.35, 1);
`,P1=T.h2` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 500;
  font-size: 0.5rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #AEAEAE;
`;function A1({amount:e}){const[t,n]=v.exports.useState(0),{messages:r}=xt(),{limitMembers:o}=Ys();return v.exports.useEffect(()=>{const i=setTimeout(()=>{n(e/o*100)},200);return()=>clearTimeout(i)},[]),_(E1,{children:ee(T1,{children:[_(b1,{children:_($1,{progress:t})}),ee(P1,{children:[e," ",r.amountOfTotal," ",o]})]})})}/*! *****************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */var Qh=function(e,t){return(Qh=Object.setPrototypeOf||{__proto__:[]}instanceof Array&&function(n,r){n.__proto__=r}||function(n,r){for(var o in r)r.hasOwnProperty(o)&&(n[o]=r[o])})(e,t)},R1,mi,N1=(function(e){/*!
  Copyright (c) 2017 Jed Watson.
  Licensed under the MIT License (MIT), see
  http://jedwatson.github.io/classnames
*/(function(){var t={}.hasOwnProperty;function n(){for(var r=[],o=0;o<arguments.length;o++){var i=arguments[o];if(i){var s=typeof i;if(s==="string"||s==="number")r.push(i);else if(Array.isArray(i)&&i.length){var l=n.apply(null,i);l&&r.push(l)}else if(s==="object")for(var a in i)t.call(i,a)&&i[a]&&r.push(a)}}return r.join(" ")}e.exports?(n.default=n,e.exports=n):window.classNames=n})()}(mi={path:R1,exports:{},require:function(e,t){return function(){throw new Error("Dynamic requires are not currently supported by @rollup/plugin-commonjs")}(t==null&&mi.path)}},mi.exports),mi.exports);function Oa(e,t,n){var r,o,i,s,l;function a(){var c=Date.now()-s;c<t&&c>=0?r=setTimeout(a,t-c):(r=null,n||(l=e.apply(i,o),i=o=null))}t==null&&(t=100);var u=function(){i=this,o=arguments,s=Date.now();var c=n&&!r;return r||(r=setTimeout(a,t)),c&&(l=e.apply(i,o),i=o=null),l};return u.clear=function(){r&&(clearTimeout(r),r=null)},u.flush=function(){r&&(l=e.apply(i,o),i=o=null,clearTimeout(r),r=null)},u}Oa.debounce=Oa;var F1=Oa;(function(e,t){t===void 0&&(t={});var n=t.insertAt;if(e&&typeof document<"u"){var r=document.head||document.getElementsByTagName("head")[0],o=document.createElement("style");o.type="text/css",n==="top"&&r.firstChild?r.insertBefore(o,r.firstChild):r.appendChild(o),o.styleSheet?o.styleSheet.cssText=e:o.appendChild(document.createTextNode(e))}})(`.indiana-scroll-container {
  overflow: auto; }
  .indiana-scroll-container--dragging {
    scroll-behavior: auto !important; }
    .indiana-scroll-container--dragging > * {
      pointer-events: none;
      cursor: -webkit-grab;
      cursor: grab; }
  .indiana-scroll-container--hide-scrollbars {
    overflow: hidden;
    overflow: -moz-scrollbars-none;
    -ms-overflow-style: none;
    scrollbar-width: none; }
    .indiana-scroll-container--hide-scrollbars::-webkit-scrollbar {
      display: none !important;
      height: 0 !important;
      width: 0 !important;
      background: transparent !important;
      -webkit-appearance: none !important; }
  .indiana-scroll-container--native-scroll {
    overflow: auto; }

.indiana-dragging {
  cursor: -webkit-grab;
  cursor: grab; }
`);var Tl,L1=(Tl="indiana-scroll-container",function(e,t){if(!e)return Tl;var n;typeof e=="string"?n=e:t=e;var r=Tl;return n&&(r+="__"+n),r+(t?Object.keys(t).reduce(function(o,i){var s=t[i];return s&&(o+=" "+(typeof s=="boolean"?r+"--"+i:r+"--"+i+"_"+s)),o},""):"")}),Yh=function(e){function t(n){var r=e.call(this,n)||this;return r.onEndScroll=function(){r.scrolling=!1,!r.pressed&&r.started&&r.processEnd()},r.onScroll=function(o){var i=r.container.current;i.scrollLeft===r.scrollLeft&&i.scrollTop===r.scrollTop||(r.scrolling=!0,r.processScroll(o),r.onEndScroll())},r.onTouchStart=function(o){var i=r.props.nativeMobileScroll;if(r.isDraggable(o.target))if(r.internal=!0,i&&r.scrolling)r.pressed=!0;else{var s=o.touches[0];r.processClick(o,s.clientX,s.clientY),!i&&r.props.stopPropagation&&o.stopPropagation()}},r.onTouchEnd=function(o){var i=r.props.nativeMobileScroll;r.pressed&&(!r.started||r.scrolling&&i?r.pressed=!1:r.processEnd(),r.forceUpdate())},r.onTouchMove=function(o){var i=r.props.nativeMobileScroll;if(r.pressed&&(!i||!r.isMobile)){var s=o.touches[0];s&&r.processMove(o,s.clientX,s.clientY),o.preventDefault(),r.props.stopPropagation&&o.stopPropagation()}},r.onMouseDown=function(o){r.isDraggable(o.target)&&r.isScrollable()&&(r.internal=!0,r.props.buttons.indexOf(o.button)!==-1&&(r.processClick(o,o.clientX,o.clientY),o.preventDefault(),r.props.stopPropagation&&o.stopPropagation()))},r.onMouseMove=function(o){r.pressed&&(r.processMove(o,o.clientX,o.clientY),o.preventDefault(),r.props.stopPropagation&&o.stopPropagation())},r.onMouseUp=function(o){r.pressed&&(r.started?r.processEnd():(r.internal=!1,r.pressed=!1,r.forceUpdate(),r.props.onClick&&r.props.onClick(o)),o.preventDefault(),r.props.stopPropagation&&o.stopPropagation())},r.container=he.createRef(),r.onEndScroll=F1(r.onEndScroll,300),r.scrolling=!1,r.started=!1,r.pressed=!1,r.internal=!1,r.getRef=r.getRef.bind(r),r}return function(n,r){function o(){this.constructor=n}Qh(n,r),n.prototype=r===null?Object.create(r):(o.prototype=r.prototype,new o)}(t,e),t.prototype.componentDidMount=function(){var n=this.props.nativeMobileScroll,r=this.container.current;window.addEventListener("mouseup",this.onMouseUp),window.addEventListener("mousemove",this.onMouseMove),window.addEventListener("touchmove",this.onTouchMove,{passive:!1}),window.addEventListener("touchend",this.onTouchEnd),r.addEventListener("touchstart",this.onTouchStart,{passive:!1}),r.addEventListener("mousedown",this.onMouseDown,{passive:!1}),n&&(this.isMobile=this.isMobileDevice(),this.isMobile&&this.forceUpdate())},t.prototype.componentWillUnmount=function(){window.removeEventListener("mouseup",this.onMouseUp),window.removeEventListener("mousemove",this.onMouseMove),window.removeEventListener("touchmove",this.onTouchMove),window.removeEventListener("touchend",this.onTouchEnd)},t.prototype.getElement=function(){return this.container.current},t.prototype.isMobileDevice=function(){return window.orientation!==void 0||navigator.userAgent.indexOf("IEMobile")!==-1},t.prototype.isDraggable=function(n){var r=this.props.ignoreElements;if(r){var o=n.closest(r);return o===null||o.contains(this.getElement())}return!0},t.prototype.isScrollable=function(){var n=this.container.current;return n&&(n.scrollWidth>n.clientWidth||n.scrollHeight>n.clientHeight)},t.prototype.processClick=function(n,r,o){var i=this.container.current;this.scrollLeft=i.scrollLeft,this.scrollTop=i.scrollTop,this.clientX=r,this.clientY=o,this.pressed=!0},t.prototype.processStart=function(n){n===void 0&&(n=!0);var r=this.props.onStartScroll;this.started=!0,n&&document.body.classList.add("indiana-dragging"),r&&r({external:!this.internal}),this.forceUpdate()},t.prototype.processScroll=function(n){if(this.started){var r=this.props.onScroll;r&&r({external:!this.internal})}else this.processStart(!1)},t.prototype.processMove=function(n,r,o){var i=this.props,s=i.horizontal,l=i.vertical,a=i.activationDistance,u=i.onScroll,c=this.container.current;this.started?(s&&(c.scrollLeft-=r-this.clientX),l&&(c.scrollTop-=o-this.clientY),u&&u({external:!this.internal}),this.clientX=r,this.clientY=o,this.scrollLeft=c.scrollLeft,this.scrollTop=c.scrollTop):(s&&Math.abs(r-this.clientX)>a||l&&Math.abs(o-this.clientY)>a)&&(this.clientX=r,this.clientY=o,this.processStart())},t.prototype.processEnd=function(){var n=this.props.onEndScroll;this.container.current&&n&&n({external:!this.internal}),this.pressed=!1,this.started=!1,this.scrolling=!1,this.internal=!1,document.body.classList.remove("indiana-dragging"),this.forceUpdate()},t.prototype.getRef=function(n){[this.container,this.props.innerRef].forEach(function(r){r&&(typeof r=="function"?r(n):r.current=n)})},t.prototype.render=function(){var n=this.props,r=n.children,o=n.draggingClassName,i=n.className,s=n.style,l=n.hideScrollbars,a=n.component;return he.createElement(a,{className:N1(i,this.pressed&&o,L1({dragging:this.pressed,"hide-scrollbars":l,"native-scroll":this.isMobile})),style:s,ref:this.getRef,onScroll:this.onScroll},r)},t.defaultProps={nativeMobileScroll:!0,hideScrollbars:!0,activationDistance:10,vertical:!0,horizontal:!0,stopPropagation:!1,style:{},component:"div",buttons:[0]},t}(v.exports.PureComponent);const M1=Yt`
  from {
    opacity: 0; 
  }
  to { 
    opacity: 1; 
  }
`,O1=T.section` 
  padding: 3.25rem 0 0 0; 

  width: 49.375rem;

  display: flex; 
  align-items: center; 
  flex-direction: column; 
  gap: 2rem;

  animation-name: ${M1};
  animation-duration: 500ms; 
  animation-fill-mode: forwards;
`,z1=T.section`
  padding: 1rem; 
    
  background: #1C1C1C;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 0.5rem;

  display: flex; 
  align-items: center;

  & > *:first-child {
    border-right: 0.0625rem solid #434343;
  }
`,I1=T.div` 
  height: 100%; 

  display: flex; 
  flex-direction: column;

  padding-right: 1rem;
`,D1=T.section` 
  display: flex;
  gap: 0.875rem; 
  align-items: center; 

  height: 100%;

  padding-left: 1rem;
`,j1=T(Yh)`
  max-width: 10rem;
  height: 100%;
  
  display: flex;
  gap: 0.5rem; 
  align-items: center; 

  ::-webkit-scrollbar {
    width: 0.125rem;
    height: 0.125rem;
  }

  ::-webkit-scrollbar-track {
    background: transparent;
  }

  ::-webkit-scrollbar-thumb {
    background: #434343;
  }

  ::-webkit-scrollbar-thumb:hover {
    background: #5f5f5f;
  }

  & > * {
    flex-shrink: 0;

    margin-bottom: 0.875rem; 
    
    align-self: end;
  }
`,V1=T.button` 
  background: #FF4E4E;
  box-shadow: 0 0 0.0625rem #FF4E4E;

  border-radius: 50%;

  width: 1.625rem;
  height: 1.625rem;

  display: flex; 
  justify-content: center; 
  align-items: center; 

  cursor: pointer;

  margin-left: 0.5rem;
`;function U1(){const{setHidden:e}=v.exports.useContext(Qo),[t,n]=v.exports.useState([]),[r,o]=v.exports.useState(),i=c=>{Fe("challengeTeam",{team:c.id})},s=async c=>{const{status:d}=await Fe("deleteTeam",{team:c.id});d&&e()},l=async c=>{const{status:d}=await Fe("leftTeam",{team:c.id});d&&e()};v.exports.useEffect(()=>{Fe("availableTeamsToChallenge",{}).then(({data:c})=>{n(c)})},[]);const a=()=>{Fe("currentTeam",{}).then(({data:c})=>{o(c)})};v.exports.useEffect(a,[]);const u=r==null?void 0:r.members.find(c=>c.myself);return ee(O1,{children:[_(Zs,{cards:t.map(c=>_(Hh,{name:c.name,button:{label:"DESAFIAR",onClick:i.bind(null,c)},members:c.members,verified:c.verified},c.id))}),r&&ee(z1,{children:[ee(I1,{children:[_(ss,{verified:r.team.verified,children:r.team.name.slice(0,10)}),_(A1,{amount:r.team.members})]}),ee(D1,{children:[_(j1,{hideScrollbars:!1,vertical:!1,children:r.members.sort(c=>c.myself?-1:1).map(({id:c,owner:d})=>_(C1,{id:c,group:d?"OWNER":(u==null?void 0:u.owner)&&u.id!==c?"KICKABLE":"NONE",updateCurrentTeam:a},c))}),_(V1,{onClick:u!=null&&u.owner?s.bind(null,r.team):l.bind(null,r.team),children:u!=null&&u.owner?_(w1,{}):_(x1,{})})]})]})]})}const B1=T.div` 
  width: 10.75rem;
  height: 8.875rem;

  background: #1C1C1C;
  border-radius: 0.5rem;

  padding: 1rem 0.25rem;

  display: flex; 
  flex-direction: column;
  align-items: center; 
  gap: 1rem;
`,W1=T.div` 
  display: flex; 
  flex-direction: column;
  align-items: center; 
  gap: 0.25rem;
`,H1=T.span`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1.5rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #FF4E4E;

  text-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
`,Z1=T.button` 
  background: #FF4E4E;
  border-radius: 0.25rem;

  padding: 0.375rem 1.5rem;

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 0.75rem;
  line-height: 120%;

  letter-spacing: 0.03em;

  color: #FFFFFF;

  cursor: pointer;
`;function Gh({teamBottom:e,teamTop:t,button:n}){return ee(B1,{children:[ee(W1,{children:[_(ss,{verified:t.verified,children:t.name.slice(0,10)}),_(H1,{children:"\xD7"}),_(ss,{verified:e.verified,children:e.name.slice(0,10)})]}),_(Z1,{onClick:n.onClick,children:n.label})]})}const Q1=Yt`
  from {
    opacity: 0; 
  }
  to { 
    opacity: 1; 
  }
`,Y1=T.section` 
  padding: 3.25rem 0 3.25rem 0; 

  width: 49.375rem;

  display: flex; 
  align-items: center; 
  flex-direction: column; 
  gap: 3rem;

  animation-name: ${Q1};
  animation-duration: 500ms; 
  animation-fill-mode: forwards;
`;function G1(){const{setHidden:e}=v.exports.useContext(Qo),[t,n]=v.exports.useState([]),{messages:r}=xt(),o=i=>{Fe("monitorGame",{game:i.id}).then(({status:s})=>{s&&e()})};return v.exports.useEffect(()=>{Fe("availableGamesToMonitor",{}).then(({data:i})=>{n(i)})},[]),_(Y1,{children:_(Zs,{cards:t.map(i=>_(Gh,{teamBottom:i.teamBottom,teamTop:i.teamTop,button:{label:r.toMonitor,onClick:o.bind(null,i)}},i.id))})})}const K1=Yt`
  from {
    opacity: 0; 
  }
  to { 
    opacity: 1; 
  }
`,X1=T.section` 
  padding: 3.25rem 0 3.25rem 0; 

  width: 49.375rem;

  display: flex; 
  align-items: center; 
  flex-direction: column; 
  gap: 3rem;

  animation-name: ${K1};
  animation-duration: 500ms; 
  animation-fill-mode: forwards;
`;function q1(){const{setHidden:e}=v.exports.useContext(Qo),[t,n]=v.exports.useState([]),{messages:r}=xt(),o=i=>{Fe("spectateGame",{game:i.id}).then(({status:s})=>{s&&e()})};return v.exports.useEffect(()=>{Fe("availableGamesToSpectate",{}).then(({data:i})=>{n(i)})},[]),_(X1,{children:_(Zs,{cards:t.map(i=>_(Gh,{teamBottom:i.teamBottom,teamTop:i.teamTop,button:{label:r.toSpectate,onClick:o.bind(null,i)}},i.id))})})}const J1=T.div` 
  width: 100%;
  height: 100%; 

  padding: 3rem 3.5rem;

  display: flex; 
  flex-direction: column; 
  align-items: center; 
`,ew=T.header` 
  width: 100%;

  display: flex; 
  flex-direction: row-reverse; 
  align-items: center; 
  gap: 2rem;
`;var Yo=e=>e.type==="checkbox",Sr=e=>e instanceof Date,tt=e=>e==null;const Kh=e=>typeof e=="object";var Be=e=>!tt(e)&&!Array.isArray(e)&&Kh(e)&&!Sr(e),Xh=e=>Be(e)&&e.target?Yo(e.target)?e.target.checked:e.target.value:e,tw=e=>e.substring(0,e.search(/\.\d+(\.|$)/))||e,qh=(e,t)=>e.has(tw(t)),Go=e=>Array.isArray(e)?e.filter(Boolean):[],Le=e=>e===void 0,j=(e,t,n)=>{if(!t||!Be(e))return n;const r=Go(t.split(/[,[\].]+?/)).reduce((o,i)=>tt(o)?o:o[i],e);return Le(r)||r===e?Le(e[t])?n:e[t]:r};const ls={BLUR:"blur",FOCUS_OUT:"focusout",CHANGE:"change"},Lt={onBlur:"onBlur",onChange:"onChange",onSubmit:"onSubmit",onTouched:"onTouched",all:"all"},Gt={max:"max",min:"min",maxLength:"maxLength",minLength:"minLength",pattern:"pattern",required:"required",validate:"validate"},nw=he.createContext(null),dc=()=>he.useContext(nw);var Jh=(e,t,n,r=!0)=>{const o={defaultValues:t._defaultValues};for(const i in e)Object.defineProperty(o,i,{get:()=>{const s=i;return t._proxyFormState[s]!==Lt.all&&(t._proxyFormState[s]=!r||Lt.all),n&&(n[s]=!0),e[s]}});return o},St=e=>Be(e)&&!Object.keys(e).length,em=(e,t,n)=>{const{name:r,...o}=e;return St(o)||Object.keys(o).length>=Object.keys(t).length||Object.keys(o).find(i=>t[i]===(!n||Lt.all))},Pi=e=>Array.isArray(e)?e:[e],tm=(e,t,n)=>n&&t?e===t:!e||!t||e===t||Pi(e).some(r=>r&&(r.startsWith(t)||t.startsWith(r)));function fc(e){const t=he.useRef(e);t.current=e,he.useEffect(()=>{const n=!e.disabled&&t.current.subject.subscribe({next:t.current.callback});return()=>{n&&n.unsubscribe()}},[e.disabled])}function rw(e){const t=dc(),{control:n=t.control,disabled:r,name:o,exact:i}=e||{},[s,l]=he.useState(n._formState),a=he.useRef(!0),u=he.useRef({isDirty:!1,dirtyFields:!1,touchedFields:!1,isValidating:!1,isValid:!1,errors:!1}),c=he.useRef(o);return c.current=o,fc({disabled:r,callback:he.useCallback(d=>a.current&&tm(c.current,d.name,i)&&em(d,u.current)&&l({...n._formState,...d}),[n,i]),subject:n._subjects.state}),he.useEffect(()=>(a.current=!0,()=>{a.current=!1}),[]),Jh(s,n,u.current,!1)}var Wt=e=>typeof e=="string",nm=(e,t,n,r)=>{const o=Array.isArray(e);return Wt(e)?(r&&t.watch.add(e),j(n,e)):o?e.map(i=>(r&&t.watch.add(i),j(n,i))):(r&&(t.watchAll=!0),n)},as=e=>typeof e=="function",pc=e=>{for(const t in e)if(as(e[t]))return!0;return!1};function ow(e){const t=dc(),{control:n=t.control,name:r,defaultValue:o,disabled:i,exact:s}=e||{},l=he.useRef(r);l.current=r,fc({disabled:i,subject:n._subjects.watch,callback:he.useCallback(c=>{if(tm(l.current,c.name,s)){const d=nm(l.current,n._names,c.values||n._formValues);u(Le(l.current)||Be(d)&&!pc(d)?{...d}:Array.isArray(d)?[...d]:Le(d)?o:d)}},[n,s,o])});const[a,u]=he.useState(Le(o)?n._getWatch(r):o);return he.useEffect(()=>n._removeUnmounted()),a}function iw(e){const t=dc(),{name:n,control:r=t.control,shouldUnregister:o}=e,i=qh(r._names.array,n),s=ow({control:r,name:n,defaultValue:j(r._formValues,n,j(r._defaultValues,n,e.defaultValue)),exact:!0}),l=rw({control:r,name:n}),a=he.useRef(r.register(n,{...e.rules,value:s}));return he.useEffect(()=>{const u=(c,d)=>{const p=j(r._fields,c);p&&(p._f.mount=d)};return u(n,!0),()=>{const c=r._options.shouldUnregister||o;(i?c&&!r._stateFlags.action:c)?r.unregister(n):u(n,!1)}},[n,r,i,o]),{field:{name:n,value:s,onChange:he.useCallback(u=>a.current.onChange({target:{value:Xh(u),name:n},type:ls.CHANGE}),[n]),onBlur:he.useCallback(()=>a.current.onBlur({target:{value:j(r._formValues,n),name:n},type:ls.BLUR}),[n,r]),ref:u=>{const c=j(r._fields,n);c&&u&&(c._f.ref={focus:()=>u.focus(),select:()=>u.select(),setCustomValidity:d=>u.setCustomValidity(d),reportValidity:()=>u.reportValidity()})}},formState:l,fieldState:Object.defineProperties({},{invalid:{enumerable:!0,get:()=>!!j(l.errors,n)},isDirty:{enumerable:!0,get:()=>!!j(l.dirtyFields,n)},isTouched:{enumerable:!0,get:()=>!!j(l.touchedFields,n)},error:{enumerable:!0,get:()=>j(l.errors,n)}})}}const sw=e=>e.render(iw(e));var rm=(e,t,n,r,o)=>t?{...n[e],types:{...n[e]&&n[e].types?n[e].types:{},[r]:o||!0}}:{},hc=e=>/^\w*$/.test(e),om=e=>Go(e.replace(/["|']|\]/g,"").split(/\.|\[/));function Se(e,t,n){let r=-1;const o=hc(t)?[t]:om(t),i=o.length,s=i-1;for(;++r<i;){const l=o[r];let a=n;if(r!==s){const u=e[l];a=Be(u)||Array.isArray(u)?u:isNaN(+o[r+1])?{}:[]}e[l]=a,e=e[l]}return e}const za=(e,t,n)=>{for(const r of n||Object.keys(e)){const o=j(e,r);if(o){const{_f:i,...s}=o;if(i&&t(i.name)){if(i.ref.focus){i.ref.focus();break}else if(i.refs&&i.refs[0].focus){i.refs[0].focus();break}}else Be(s)&&za(s,t)}}};var Vd=(e,t,n)=>!n&&(t.watchAll||t.watch.has(e)||[...t.watch].some(r=>e.startsWith(r)&&/^\.\w+/.test(e.slice(r.length)))),lw=(e,t,n)=>{const r=Go(j(e,n));return Se(r,"root",t[n]),Se(e,n,r),e},us=e=>typeof e=="boolean",mc=e=>e.type==="file",Ai=e=>Wt(e)||he.isValidElement(e),gc=e=>e.type==="radio",cs=e=>e instanceof RegExp;const Ud={value:!1,isValid:!1},Bd={value:!0,isValid:!0};var im=e=>{if(Array.isArray(e)){if(e.length>1){const t=e.filter(n=>n&&n.checked&&!n.disabled).map(n=>n.value);return{value:t,isValid:!!t.length}}return e[0].checked&&!e[0].disabled?e[0].attributes&&!Le(e[0].attributes.value)?Le(e[0].value)||e[0].value===""?Bd:{value:e[0].value,isValid:!0}:Bd:Ud}return Ud};const Wd={isValid:!1,value:null};var sm=e=>Array.isArray(e)?e.reduce((t,n)=>n&&n.checked&&!n.disabled?{isValid:!0,value:n.value}:t,Wd):Wd;function Hd(e,t,n="validate"){if(Ai(e)||Array.isArray(e)&&e.every(Ai)||us(e)&&!e)return{type:n,message:Ai(e)?e:"",ref:t}}var sr=e=>Be(e)&&!cs(e)?e:{value:e,message:""},Zd=async(e,t,n,r,o)=>{const{ref:i,refs:s,required:l,maxLength:a,minLength:u,min:c,max:d,pattern:p,validate:C,name:S,valueAsNumber:E,mount:M,disabled:h}=e._f;if(!M||h)return{};const f=s?s[0]:i,g=Z=>{r&&f.reportValidity&&(f.setCustomValidity(us(Z)?"":Z||" "),f.reportValidity())},x={},$=gc(i),z=Yo(i),D=$||z,I=(E||mc(i))&&!i.value||t===""||Array.isArray(t)&&!t.length,te=rm.bind(null,S,n,x),K=(Z,Y,ae,ve=Gt.maxLength,we=Gt.minLength)=>{const He=Z?Y:ae;x[S]={type:Z?ve:we,message:He,ref:i,...te(Z?ve:we,He)}};if(o?!Array.isArray(t)||!t.length:l&&(!D&&(I||tt(t))||us(t)&&!t||z&&!im(s).isValid||$&&!sm(s).isValid)){const{value:Z,message:Y}=Ai(l)?{value:!!l,message:l}:sr(l);if(Z&&(x[S]={type:Gt.required,message:Y,ref:f,...te(Gt.required,Y)},!n))return g(Y),x}if(!I&&(!tt(c)||!tt(d))){let Z,Y;const ae=sr(d),ve=sr(c);if(!tt(t)&&!isNaN(t)){const we=i.valueAsNumber||t&&+t;tt(ae.value)||(Z=we>ae.value),tt(ve.value)||(Y=we<ve.value)}else{const we=i.valueAsDate||new Date(t);Wt(ae.value)&&(Z=we>new Date(ae.value)),Wt(ve.value)&&(Y=we<new Date(ve.value))}if((Z||Y)&&(K(!!Z,ae.message,ve.message,Gt.max,Gt.min),!n))return g(x[S].message),x}if((a||u)&&!I&&(Wt(t)||o&&Array.isArray(t))){const Z=sr(a),Y=sr(u),ae=!tt(Z.value)&&t.length>Z.value,ve=!tt(Y.value)&&t.length<Y.value;if((ae||ve)&&(K(ae,Z.message,Y.message),!n))return g(x[S].message),x}if(p&&!I&&Wt(t)){const{value:Z,message:Y}=sr(p);if(cs(Z)&&!t.match(Z)&&(x[S]={type:Gt.pattern,message:Y,ref:i,...te(Gt.pattern,Y)},!n))return g(Y),x}if(C){if(as(C)){const Z=await C(t),Y=Hd(Z,f);if(Y&&(x[S]={...Y,...te(Gt.validate,Y.message)},!n))return g(Y.message),x}else if(Be(C)){let Z={};for(const Y in C){if(!St(Z)&&!n)break;const ae=Hd(await C[Y](t),f,Y);ae&&(Z={...ae,...te(Y,ae.message)},g(ae.message),n&&(x[S]=Z))}if(!St(Z)&&(x[S]={ref:f,...Z},!n))return x}}return g(!0),x},aw=e=>{const t=e.constructor&&e.constructor.prototype;return Be(t)&&t.hasOwnProperty("isPrototypeOf")},Ia=typeof window<"u"&&typeof window.HTMLElement<"u"&&typeof document<"u";function Vn(e){let t;const n=Array.isArray(e);if(e instanceof Date)t=new Date(e);else if(e instanceof Set)t=new Set(e);else if(!(Ia&&(e instanceof Blob||e instanceof FileList))&&(n||Be(e)))if(t=n?[]:{},!Array.isArray(e)&&!aw(e))t=e;else for(const r in e)t[r]=Vn(e[r]);else return e;return t}var Qd=e=>({isOnSubmit:!e||e===Lt.onSubmit,isOnBlur:e===Lt.onBlur,isOnChange:e===Lt.onChange,isOnAll:e===Lt.all,isOnTouch:e===Lt.onTouched});function uw(e,t){const n=t.slice(0,-1).length;let r=0;for(;r<n;)e=Le(e)?r++:e[t[r++]];return e}function cw(e){for(const t in e)if(!Le(e[t]))return!1;return!0}function Je(e,t){const n=hc(t)?[t]:om(t),r=n.length==1?e:uw(e,n),o=n[n.length-1];let i;r&&delete r[o];for(let s=0;s<n.slice(0,-1).length;s++){let l=-1,a;const u=n.slice(0,-(s+1)),c=u.length-1;for(s>0&&(i=e);++l<u.length;){const d=u[l];a=a?a[d]:e[d],c===l&&(Be(a)&&St(a)||Array.isArray(a)&&cw(a))&&(i?delete i[d]:delete e[d]),i=a}}return e}function bl(){let e=[];return{get observers(){return e},next:o=>{for(const i of e)i.next(o)},subscribe:o=>(e.push(o),{unsubscribe:()=>{e=e.filter(i=>i!==o)}}),unsubscribe:()=>{e=[]}}}var ds=e=>tt(e)||!Kh(e);function _r(e,t){if(ds(e)||ds(t))return e===t;if(Sr(e)&&Sr(t))return e.getTime()===t.getTime();const n=Object.keys(e),r=Object.keys(t);if(n.length!==r.length)return!1;for(const o of n){const i=e[o];if(!r.includes(o))return!1;if(o!=="ref"){const s=t[o];if(Sr(i)&&Sr(s)||Be(i)&&Be(s)||Array.isArray(i)&&Array.isArray(s)?!_r(i,s):i!==s)return!1}}return!0}var Da=e=>{const t=e?e.ownerDocument:0,n=t&&t.defaultView?t.defaultView.HTMLElement:HTMLElement;return e instanceof n},lm=e=>e.type==="select-multiple",dw=e=>gc(e)||Yo(e),$l=e=>Da(e)&&e.isConnected;function fs(e,t={}){const n=Array.isArray(e);if(Be(e)||n)for(const r in e)Array.isArray(e[r])||Be(e[r])&&!pc(e[r])?(t[r]=Array.isArray(e[r])?[]:{},fs(e[r],t[r])):tt(e[r])||(t[r]=!0);return t}function am(e,t,n){const r=Array.isArray(e);if(Be(e)||r)for(const o in e)Array.isArray(e[o])||Be(e[o])&&!pc(e[o])?Le(t)||ds(n[o])?n[o]=Array.isArray(e[o])?fs(e[o],[]):{...fs(e[o])}:am(e[o],tt(t)?{}:t[o],n[o]):n[o]=!_r(e[o],t[o]);return n}var Pl=(e,t)=>am(e,t,fs(t)),um=(e,{valueAsNumber:t,valueAsDate:n,setValueAs:r})=>Le(e)?e:t?e===""?NaN:e&&+e:n&&Wt(e)?new Date(e):r?r(e):e;function Al(e){const t=e.ref;if(!(e.refs?e.refs.every(n=>n.disabled):t.disabled))return mc(t)?t.files:gc(t)?sm(e.refs).value:lm(t)?[...t.selectedOptions].map(({value:n})=>n):Yo(t)?im(e.refs).value:um(Le(t.value)?e.ref.value:t.value,e)}var fw=(e,t,n,r)=>{const o={};for(const i of e){const s=j(t,i);s&&Se(o,i,s._f)}return{criteriaMode:n,names:[...e],fields:o,shouldUseNativeValidation:r}},ro=e=>Le(e)?void 0:cs(e)?e.source:Be(e)?cs(e.value)?e.value.source:e.value:e,pw=e=>e.mount&&(e.required||e.min||e.max||e.maxLength||e.minLength||e.pattern||e.validate);function Yd(e,t,n){const r=j(e,n);if(r||hc(n))return{error:r,name:n};const o=n.split(".");for(;o.length;){const i=o.join("."),s=j(t,i),l=j(e,i);if(s&&!Array.isArray(s)&&n!==i)return{name:n};if(l&&l.type)return{name:i,error:l};o.pop()}return{name:n}}var hw=(e,t,n,r,o)=>o.isOnAll?!1:!n&&o.isOnTouch?!(t||e):(n?r.isOnBlur:o.isOnBlur)?!e:(n?r.isOnChange:o.isOnChange)?e:!0,mw=(e,t)=>!Go(j(e,t)).length&&Je(e,t);const gw={mode:Lt.onSubmit,reValidateMode:Lt.onChange,shouldFocusError:!0};function yw(e={}){let t={...gw,...e},n={submitCount:0,isDirty:!1,isValidating:!1,isSubmitted:!1,isSubmitting:!1,isSubmitSuccessful:!1,isValid:!1,touchedFields:{},dirtyFields:{},errors:{}},r={},o=Vn(t.defaultValues)||{},i=t.shouldUnregister?{}:Vn(o),s={action:!1,mount:!1,watch:!1},l={mount:new Set,unMount:new Set,array:new Set,watch:new Set},a,u=0,c={};const d={isDirty:!1,dirtyFields:!1,touchedFields:!1,isValidating:!1,isValid:!1,errors:!1},p={watch:bl(),array:bl(),state:bl()},C=Qd(t.mode),S=Qd(t.reValidateMode),E=t.criteriaMode===Lt.all,M=m=>y=>{clearTimeout(u),u=window.setTimeout(m,y)},h=async m=>{let y=!1;return d.isValid&&(y=t.resolver?St((await D()).errors):await te(r,!0),!m&&y!==n.isValid&&(n.isValid=y,p.state.next({isValid:y}))),y},f=(m,y=[],k,N,P=!0,b=!0)=>{if(N&&k){if(s.action=!0,b&&Array.isArray(j(r,m))){const R=k(j(r,m),N.argA,N.argB);P&&Se(r,m,R)}if(d.errors&&b&&Array.isArray(j(n.errors,m))){const R=k(j(n.errors,m),N.argA,N.argB);P&&Se(n.errors,m,R),mw(n.errors,m)}if(d.touchedFields&&b&&Array.isArray(j(n.touchedFields,m))){const R=k(j(n.touchedFields,m),N.argA,N.argB);P&&Se(n.touchedFields,m,R)}d.dirtyFields&&(n.dirtyFields=Pl(o,i)),p.state.next({isDirty:Z(m,y),dirtyFields:n.dirtyFields,errors:n.errors,isValid:n.isValid})}else Se(i,m,y)},g=(m,y)=>{Se(n.errors,m,y),p.state.next({errors:n.errors})},x=(m,y,k,N)=>{const P=j(r,m);if(P){const b=j(i,m,Le(k)?j(o,m):k);Le(b)||N&&N.defaultChecked||y?Se(i,m,y?b:Al(P._f)):ve(m,b),s.mount&&h()}},$=(m,y,k,N,P)=>{let b=!1;const R={name:m},oe=j(n.touchedFields,m);if(d.isDirty){const ze=n.isDirty;n.isDirty=R.isDirty=Z(),b=ze!==R.isDirty}if(d.dirtyFields&&(!k||N)){const ze=j(n.dirtyFields,m);_r(j(o,m),y)?Je(n.dirtyFields,m):Se(n.dirtyFields,m,!0),R.dirtyFields=n.dirtyFields,b=b||ze!==j(n.dirtyFields,m)}return k&&!oe&&(Se(n.touchedFields,m,k),R.touchedFields=n.touchedFields,b=b||d.touchedFields&&oe!==k),b&&P&&p.state.next(R),b?R:{}},z=async(m,y,k,N)=>{const P=j(n.errors,m),b=d.isValid&&n.isValid!==y;if(e.delayError&&k?(a=M(()=>g(m,k)),a(e.delayError)):(clearTimeout(u),a=null,k?Se(n.errors,m,k):Je(n.errors,m)),(k?!_r(P,k):P)||!St(N)||b){const R={...N,...b?{isValid:y}:{},errors:n.errors,name:m};n={...n,...R},p.state.next(R)}c[m]--,d.isValidating&&!Object.values(c).some(R=>R)&&(p.state.next({isValidating:!1}),c={})},D=async m=>t.resolver?await t.resolver({...i},t.context,fw(m||l.mount,r,t.criteriaMode,t.shouldUseNativeValidation)):{},I=async m=>{const{errors:y}=await D();if(m)for(const k of m){const N=j(y,k);N?Se(n.errors,k,N):Je(n.errors,k)}else n.errors=y;return y},te=async(m,y,k={valid:!0})=>{for(const N in m){const P=m[N];if(P){const{_f:b,...R}=P;if(b){const oe=l.array.has(b.name),ze=await Zd(P,j(i,b.name),E,t.shouldUseNativeValidation,oe);if(ze[b.name]&&(k.valid=!1,y))break;!y&&(j(ze,b.name)?oe?lw(n.errors,ze,b.name):Se(n.errors,b.name,ze[b.name]):Je(n.errors,b.name))}R&&await te(R,y,k)}}return k.valid},K=()=>{for(const m of l.unMount){const y=j(r,m);y&&(y._f.refs?y._f.refs.every(k=>!$l(k)):!$l(y._f.ref))&&U(m)}l.unMount=new Set},Z=(m,y)=>(m&&y&&Se(i,m,y),!_r(G(),o)),Y=(m,y,k)=>{const N={...s.mount?i:Le(y)?o:Wt(m)?{[m]:y}:y};return nm(m,l,N,k)},ae=m=>Go(j(s.mount?i:o,m,e.shouldUnregister?j(o,m,[]):[])),ve=(m,y,k={})=>{const N=j(r,m);let P=y;if(N){const b=N._f;b&&(!b.disabled&&Se(i,m,um(y,b)),P=Ia&&Da(b.ref)&&tt(y)?"":y,lm(b.ref)?[...b.ref.options].forEach(R=>R.selected=P.includes(R.value)):b.refs?Yo(b.ref)?b.refs.length>1?b.refs.forEach(R=>(!R.defaultChecked||!R.disabled)&&(R.checked=Array.isArray(P)?!!P.find(oe=>oe===R.value):P===R.value)):b.refs[0]&&(b.refs[0].checked=!!P):b.refs.forEach(R=>R.checked=R.value===P):mc(b.ref)?b.ref.value="":(b.ref.value=P,b.ref.type||p.watch.next({name:m})))}(k.shouldDirty||k.shouldTouch)&&$(m,P,k.shouldTouch,k.shouldDirty,!0),k.shouldValidate&&F(m)},we=(m,y,k)=>{for(const N in y){const P=y[N],b=`${m}.${N}`,R=j(r,b);(l.array.has(m)||!ds(P)||R&&!R._f)&&!Sr(P)?we(b,P,k):ve(b,P,k)}},He=(m,y,k={})=>{const N=j(r,m),P=l.array.has(m),b=Vn(y);Se(i,m,b),P?(p.array.next({name:m,values:i}),(d.isDirty||d.dirtyFields)&&k.shouldDirty&&(n.dirtyFields=Pl(o,i),p.state.next({name:m,dirtyFields:n.dirtyFields,isDirty:Z(m,b)}))):N&&!N._f&&!tt(b)?we(m,b,k):ve(m,b,k),Vd(m,l)&&p.state.next({}),p.watch.next({name:m})},je=async m=>{const y=m.target;let k=y.name;const N=j(r,k);if(N){let P,b;const R=y.type?Al(N._f):Xh(m),oe=m.type===ls.BLUR||m.type===ls.FOCUS_OUT,ze=!pw(N._f)&&!t.resolver&&!j(n.errors,k)&&!N._f.deps||hw(oe,j(n.touchedFields,k),n.isSubmitted,S,C),Re=Vd(k,l,oe);Se(i,k,R),oe?(N._f.onBlur&&N._f.onBlur(m),a&&a(0)):N._f.onChange&&N._f.onChange(m);const dn=$(k,R,oe,!1),In=!St(dn)||Re;if(!oe&&p.watch.next({name:k,type:m.type}),ze)return In&&p.state.next({name:k,...Re?{}:dn});if(!oe&&Re&&p.state.next({}),c[k]=(c[k],1),p.state.next({isValidating:!0}),t.resolver){const{errors:it}=await D([k]),J=Yd(n.errors,r,k),Ce=Yd(it,r,J.name||k);P=Ce.error,k=Ce.name,b=St(it)}else P=(await Zd(N,j(i,k),E,t.shouldUseNativeValidation))[k],b=await h(!0);N._f.deps&&F(N._f.deps),z(k,b,P,dn)}},F=async(m,y={})=>{let k,N;const P=Pi(m);if(p.state.next({isValidating:!0}),t.resolver){const b=await I(Le(m)?m:P);k=St(b),N=m?!P.some(R=>j(b,R)):k}else m?(N=(await Promise.all(P.map(async b=>{const R=j(r,b);return await te(R&&R._f?{[b]:R}:R)}))).every(Boolean),!(!N&&!n.isValid)&&h()):N=k=await te(r);return p.state.next({...!Wt(m)||d.isValid&&k!==n.isValid?{}:{name:m},...t.resolver?{isValid:k}:{},errors:n.errors,isValidating:!1}),y.shouldFocus&&!N&&za(r,b=>j(n.errors,b),m?P:l.mount),N},G=m=>{const y={...o,...s.mount?i:{}};return Le(m)?y:Wt(m)?j(y,m):m.map(k=>j(y,k))},q=(m,y)=>({invalid:!!j((y||n).errors,m),isDirty:!!j((y||n).dirtyFields,m),isTouched:!!j((y||n).touchedFields,m),error:j((y||n).errors,m)}),me=m=>{m?Pi(m).forEach(y=>Je(n.errors,y)):n.errors={},p.state.next({errors:n.errors})},O=(m,y,k)=>{const N=(j(r,m,{_f:{}})._f||{}).ref;Se(n.errors,m,{...y,ref:N}),p.state.next({name:m,errors:n.errors,isValid:!1}),k&&k.shouldFocus&&N&&N.focus&&N.focus()},V=(m,y)=>as(m)?p.watch.subscribe({next:k=>m(Y(void 0,y),k)}):Y(m,y,!0),U=(m,y={})=>{for(const k of m?Pi(m):l.mount)l.mount.delete(k),l.array.delete(k),j(r,k)&&(y.keepValue||(Je(r,k),Je(i,k)),!y.keepError&&Je(n.errors,k),!y.keepDirty&&Je(n.dirtyFields,k),!y.keepTouched&&Je(n.touchedFields,k),!t.shouldUnregister&&!y.keepDefaultValue&&Je(o,k));p.watch.next({}),p.state.next({...n,...y.keepDirty?{isDirty:Z()}:{}}),!y.keepIsValid&&h()},X=(m,y={})=>{let k=j(r,m);const N=us(y.disabled);return Se(r,m,{...k||{},_f:{...k&&k._f?k._f:{ref:{name:m}},name:m,mount:!0,...y}}),l.mount.add(m),k?N&&Se(i,m,y.disabled?void 0:j(i,m,Al(k._f))):x(m,!0,y.value),{...N?{disabled:y.disabled}:{},...t.shouldUseNativeValidation?{required:!!y.required,min:ro(y.min),max:ro(y.max),minLength:ro(y.minLength),maxLength:ro(y.maxLength),pattern:ro(y.pattern)}:{},name:m,onChange:je,onBlur:je,ref:P=>{if(P){X(m,y),k=j(r,m);const b=Le(P.value)&&P.querySelectorAll&&P.querySelectorAll("input,select,textarea")[0]||P,R=dw(b),oe=k._f.refs||[];if(R?oe.find(ze=>ze===b):b===k._f.ref)return;Se(r,m,{_f:{...k._f,...R?{refs:[...oe.filter($l),b,...Array.isArray(j(o,m))?[{}]:[]],ref:{type:b.type,name:m}}:{ref:b}}}),x(m,!1,void 0,b)}else k=j(r,m,{}),k._f&&(k._f.mount=!1),(t.shouldUnregister||y.shouldUnregister)&&!(qh(l.array,m)&&s.action)&&l.unMount.add(m)}}},w=(m,y)=>async k=>{k&&(k.preventDefault&&k.preventDefault(),k.persist&&k.persist());let N=!0,P=Vn(i);p.state.next({isSubmitting:!0});try{if(t.resolver){const{errors:b,values:R}=await D();n.errors=b,P=R}else await te(r);St(n.errors)?(p.state.next({errors:{},isSubmitting:!0}),await m(P,k)):(y&&await y({...n.errors},k),t.shouldFocusError&&za(r,b=>j(n.errors,b),l.mount))}catch(b){throw N=!1,b}finally{n.isSubmitted=!0,p.state.next({isSubmitted:!0,isSubmitting:!1,isSubmitSuccessful:St(n.errors)&&N,submitCount:n.submitCount+1,errors:n.errors})}},ie=(m,y={})=>{j(r,m)&&(Le(y.defaultValue)?He(m,j(o,m)):(He(m,y.defaultValue),Se(o,m,y.defaultValue)),y.keepTouched||Je(n.touchedFields,m),y.keepDirty||(Je(n.dirtyFields,m),n.isDirty=y.defaultValue?Z(m,j(o,m)):Z()),y.keepError||(Je(n.errors,m),d.isValid&&h()),p.state.next({...n}))},L=(m,y={})=>{const k=m||o,N=Vn(k),P=m&&!St(m)?N:o;if(y.keepDefaultValues||(o=k),!y.keepValues){if(y.keepDirtyValues)for(const b of l.mount)j(n.dirtyFields,b)?Se(P,b,j(i,b)):He(b,j(P,b));else{if(Ia&&Le(m))for(const b of l.mount){const R=j(r,b);if(R&&R._f){const oe=Array.isArray(R._f.refs)?R._f.refs[0]:R._f.ref;try{if(Da(oe)){oe.closest("form").reset();break}}catch{}}}r={}}i=e.shouldUnregister?y.keepDefaultValues?Vn(o):{}:N,p.array.next({values:P}),p.watch.next({values:P})}l={mount:new Set,unMount:new Set,array:new Set,watch:new Set,watchAll:!1,focus:""},s.mount=!d.isValid||!!y.keepIsValid,s.watch=!!e.shouldUnregister,p.state.next({submitCount:y.keepSubmitCount?n.submitCount:0,isDirty:y.keepDirty||y.keepDirtyValues?n.isDirty:!!(y.keepDefaultValues&&!_r(m,o)),isSubmitted:y.keepIsSubmitted?n.isSubmitted:!1,dirtyFields:y.keepDirty||y.keepDirtyValues?n.dirtyFields:y.keepDefaultValues&&m?Pl(o,m):{},touchedFields:y.keepTouched?n.touchedFields:{},errors:y.keepErrors?n.errors:{},isSubmitting:!1,isSubmitSuccessful:!1})};return{control:{register:X,unregister:U,getFieldState:q,_executeSchema:D,_getWatch:Y,_getDirty:Z,_updateValid:h,_removeUnmounted:K,_updateFieldArray:f,_getFieldArray:ae,_subjects:p,_proxyFormState:d,get _fields(){return r},get _formValues(){return i},get _stateFlags(){return s},set _stateFlags(m){s=m},get _defaultValues(){return o},get _names(){return l},set _names(m){l=m},get _formState(){return n},set _formState(m){n=m},get _options(){return t},set _options(m){t={...t,...m}}},trigger:F,register:X,handleSubmit:w,watch:V,setValue:He,getValues:G,reset:(m,y)=>L(as(m)?m(i):m,y),resetField:ie,clearErrors:me,unregister:U,setError:O,setFocus:(m,y={})=>{const k=j(r,m),N=k&&k._f;if(N){const P=N.refs?N.refs[0]:N.ref;P.focus&&(P.focus(),y.shouldSelect&&P.select())}},getFieldState:q}}function yc(e={}){const t=he.useRef(),[n,r]=he.useState({isDirty:!1,isValidating:!1,isSubmitted:!1,isSubmitting:!1,isSubmitSuccessful:!1,isValid:!1,submitCount:0,dirtyFields:{},touchedFields:{},errors:{},defaultValues:e.defaultValues});t.current||(t.current={...yw(e),formState:n});const o=t.current.control;return o._options=e,fc({subject:o._subjects.state,callback:he.useCallback(i=>{em(i,o._proxyFormState,!0)&&(o._formState={...o._formState,...i},r({...o._formState}))},[o])}),he.useEffect(()=>{o._stateFlags.mount||(o._proxyFormState.isValid&&o._updateValid(),o._stateFlags.mount=!0),o._stateFlags.watch&&(o._stateFlags.watch=!1,o._subjects.state.next({})),o._removeUnmounted()}),t.current.formState=Jh(n,o),t.current}var Gd=function(e,t,n){if(e&&"reportValidity"in e){var r=j(n,t);e.setCustomValidity(r&&r.message||""),e.reportValidity()}},cm=function(e,t){var n=function(o){var i=t.fields[o];i&&i.ref&&"reportValidity"in i.ref?Gd(i.ref,o,e):i.refs&&i.refs.forEach(function(s){return Gd(s,o,e)})};for(var r in t.fields)n(r)},vw=function(e,t){t.shouldUseNativeValidation&&cm(e,t);var n={};for(var r in e){var o=j(t.fields,r);Se(n,r,Object.assign(e[r],{ref:o&&o.ref}))}return n},ww=function(e,t){for(var n={};e.length;){var r=e[0],o=r.code,i=r.message,s=r.path.join(".");if(!n[s])if("unionErrors"in r){var l=r.unionErrors[0].errors[0];n[s]={message:l.message,type:l.code}}else n[s]={message:i,type:o};if("unionErrors"in r&&r.unionErrors.forEach(function(c){return c.errors.forEach(function(d){return e.push(d)})}),t){var a=n[s].types,u=a&&a[r.code];n[s]=rm(s,t,n,o,u?[].concat(u,r.message):r.message)}e.shift()}return n},dm=function(e,t,n){return n===void 0&&(n={}),function(r,o,i){try{return Promise.resolve(function(s,l){try{var a=Promise.resolve(e[n.mode==="sync"?"parse":"parseAsync"](r,t)).then(function(u){return i.shouldUseNativeValidation&&cm({},i),{errors:{},values:n.rawValues?r:u}})}catch(u){return l(u)}return a&&a.then?a.then(void 0,l):a}(0,function(s){return{values:{},errors:s.isEmpty?{}:vw(ww(s.errors,!i.shouldUseNativeValidation&&i.criteriaMode==="all"),i)}}))}catch(s){return Promise.reject(s)}}},pe;(function(e){e.assertEqual=o=>o;function t(o){}e.assertIs=t;function n(o){throw new Error}e.assertNever=n,e.arrayToEnum=o=>{const i={};for(const s of o)i[s]=s;return i},e.getValidEnumValues=o=>{const i=e.objectKeys(o).filter(l=>typeof o[o[l]]!="number"),s={};for(const l of i)s[l]=o[l];return e.objectValues(s)},e.objectValues=o=>e.objectKeys(o).map(function(i){return o[i]}),e.objectKeys=typeof Object.keys=="function"?o=>Object.keys(o):o=>{const i=[];for(const s in o)Object.prototype.hasOwnProperty.call(o,s)&&i.push(s);return i},e.find=(o,i)=>{for(const s of o)if(i(s))return s},e.isInteger=typeof Number.isInteger=="function"?o=>Number.isInteger(o):o=>typeof o=="number"&&isFinite(o)&&Math.floor(o)===o;function r(o,i=" | "){return o.map(s=>typeof s=="string"?`'${s}'`:s).join(i)}e.joinValues=r,e.jsonStringifyReplacer=(o,i)=>typeof i=="bigint"?i.toString():i})(pe||(pe={}));const H=pe.arrayToEnum(["string","nan","number","integer","float","boolean","date","bigint","symbol","function","undefined","null","array","object","unknown","promise","void","never","map","set"]),Un=e=>{switch(typeof e){case"undefined":return H.undefined;case"string":return H.string;case"number":return isNaN(e)?H.nan:H.number;case"boolean":return H.boolean;case"function":return H.function;case"bigint":return H.bigint;case"object":return Array.isArray(e)?H.array:e===null?H.null:e.then&&typeof e.then=="function"&&e.catch&&typeof e.catch=="function"?H.promise:typeof Map<"u"&&e instanceof Map?H.map:typeof Set<"u"&&e instanceof Set?H.set:typeof Date<"u"&&e instanceof Date?H.date:H.object;default:return H.unknown}},B=pe.arrayToEnum(["invalid_type","invalid_literal","custom","invalid_union","invalid_union_discriminator","invalid_enum_value","unrecognized_keys","invalid_arguments","invalid_return_type","invalid_date","invalid_string","too_small","too_big","invalid_intersection_types","not_multiple_of"]);class Pn extends Error{constructor(t){super(),this.issues=[],this.addIssue=r=>{this.issues=[...this.issues,r]},this.addIssues=(r=[])=>{this.issues=[...this.issues,...r]};const n=new.target.prototype;Object.setPrototypeOf?Object.setPrototypeOf(this,n):this.__proto__=n,this.name="ZodError",this.issues=t}get errors(){return this.issues}format(t){const n=t||function(i){return i.message},r={_errors:[]},o=i=>{for(const s of i.issues)if(s.code==="invalid_union")s.unionErrors.map(o);else if(s.code==="invalid_return_type")o(s.returnTypeError);else if(s.code==="invalid_arguments")o(s.argumentsError);else if(s.path.length===0)r._errors.push(n(s));else{let l=r,a=0;for(;a<s.path.length;){const u=s.path[a];a===s.path.length-1?(l[u]=l[u]||{_errors:[]},l[u]._errors.push(n(s))):l[u]=l[u]||{_errors:[]},l=l[u],a++}}};return o(this),r}toString(){return this.message}get message(){return JSON.stringify(this.issues,pe.jsonStringifyReplacer,2)}get isEmpty(){return this.issues.length===0}flatten(t=n=>n.message){const n={},r=[];for(const o of this.issues)o.path.length>0?(n[o.path[0]]=n[o.path[0]]||[],n[o.path[0]].push(t(o))):r.push(t(o));return{formErrors:r,fieldErrors:n}}get formErrors(){return this.flatten()}}Pn.create=e=>new Pn(e);const ps=(e,t)=>{let n;switch(e.code){case B.invalid_type:e.received===H.undefined?n="Required":n=`Expected ${e.expected}, received ${e.received}`;break;case B.invalid_literal:n=`Invalid literal value, expected ${JSON.stringify(e.expected,pe.jsonStringifyReplacer)}`;break;case B.unrecognized_keys:n=`Unrecognized key(s) in object: ${pe.joinValues(e.keys,", ")}`;break;case B.invalid_union:n="Invalid input";break;case B.invalid_union_discriminator:n=`Invalid discriminator value. Expected ${pe.joinValues(e.options)}`;break;case B.invalid_enum_value:n=`Invalid enum value. Expected ${pe.joinValues(e.options)}, received '${e.received}'`;break;case B.invalid_arguments:n="Invalid function arguments";break;case B.invalid_return_type:n="Invalid function return type";break;case B.invalid_date:n="Invalid date";break;case B.invalid_string:typeof e.validation=="object"?"startsWith"in e.validation?n=`Invalid input: must start with "${e.validation.startsWith}"`:"endsWith"in e.validation?n=`Invalid input: must end with "${e.validation.endsWith}"`:pe.assertNever(e.validation):e.validation!=="regex"?n=`Invalid ${e.validation}`:n="Invalid";break;case B.too_small:e.type==="array"?n=`Array must contain ${e.inclusive?"at least":"more than"} ${e.minimum} element(s)`:e.type==="string"?n=`String must contain ${e.inclusive?"at least":"over"} ${e.minimum} character(s)`:e.type==="number"?n=`Number must be greater than ${e.inclusive?"or equal to ":""}${e.minimum}`:e.type==="date"?n=`Date must be greater than ${e.inclusive?"or equal to ":""}${new Date(e.minimum)}`:n="Invalid input";break;case B.too_big:e.type==="array"?n=`Array must contain ${e.inclusive?"at most":"less than"} ${e.maximum} element(s)`:e.type==="string"?n=`String must contain ${e.inclusive?"at most":"under"} ${e.maximum} character(s)`:e.type==="number"?n=`Number must be less than ${e.inclusive?"or equal to ":""}${e.maximum}`:e.type==="date"?n=`Date must be smaller than ${e.inclusive?"or equal to ":""}${new Date(e.maximum)}`:n="Invalid input";break;case B.custom:n="Invalid input";break;case B.invalid_intersection_types:n="Intersection results could not be merged";break;case B.not_multiple_of:n=`Number must be a multiple of ${e.multipleOf}`;break;default:n=t.defaultError,pe.assertNever(e)}return{message:n}};let xw=ps;function ja(){return xw}const Va=e=>{const{data:t,path:n,errorMaps:r,issueData:o}=e,i=[...n,...o.path||[]],s={...o,path:i};let l="";const a=r.filter(u=>!!u).slice().reverse();for(const u of a)l=u(s,{data:t,defaultError:l}).message;return{...o,path:i,message:o.message||l}};function Q(e,t){const n=Va({issueData:t,data:e.data,path:e.path,errorMaps:[e.common.contextualErrorMap,e.schemaErrorMap,ja(),ps].filter(r=>!!r)});e.common.issues.push(n)}class ft{constructor(){this.value="valid"}dirty(){this.value==="valid"&&(this.value="dirty")}abort(){this.value!=="aborted"&&(this.value="aborted")}static mergeArray(t,n){const r=[];for(const o of n){if(o.status==="aborted")return re;o.status==="dirty"&&t.dirty(),r.push(o.value)}return{status:t.value,value:r}}static async mergeObjectAsync(t,n){const r=[];for(const o of n)r.push({key:await o.key,value:await o.value});return ft.mergeObjectSync(t,r)}static mergeObjectSync(t,n){const r={};for(const o of n){const{key:i,value:s}=o;if(i.status==="aborted"||s.status==="aborted")return re;i.status==="dirty"&&t.dirty(),s.status==="dirty"&&t.dirty(),(typeof s.value<"u"||o.alwaysSet)&&(r[i.value]=s.value)}return{status:t.value,value:r}}}const re=Object.freeze({status:"aborted"}),pt=e=>({status:"valid",value:e}),Kd=e=>e.status==="aborted",Xd=e=>e.status==="dirty",Ua=e=>e.status==="valid",qd=e=>typeof Promise!==void 0&&e instanceof Promise;var de;(function(e){e.errToObj=t=>typeof t=="string"?{message:t}:t||{},e.toString=t=>typeof t=="string"?t:t==null?void 0:t.message})(de||(de={}));class Qt{constructor(t,n,r,o){this.parent=t,this.data=n,this._path=r,this._key=o}get path(){return this._path.concat(this._key)}}const Jd=(e,t)=>{if(Ua(t))return{success:!0,data:t.value};{if(!e.common.issues.length)throw new Error("Validation failed but no issues detected.");const n=new Pn(e.common.issues);return{success:!1,error:n}}};function se(e){if(!e)return{};const{errorMap:t,invalid_type_error:n,required_error:r,description:o}=e;if(t&&(n||r))throw new Error(`Can't use "invalid_type_error" or "required_error" in conjunction with custom error map.`);return t?{errorMap:t,description:o}:{errorMap:(s,l)=>s.code!=="invalid_type"?{message:l.defaultError}:typeof l.data>"u"?{message:r!=null?r:l.defaultError}:{message:n!=null?n:l.defaultError},description:o}}class ce{constructor(t){this.spa=this.safeParseAsync,this.superRefine=this._refinement,this._def=t,this.parse=this.parse.bind(this),this.safeParse=this.safeParse.bind(this),this.parseAsync=this.parseAsync.bind(this),this.safeParseAsync=this.safeParseAsync.bind(this),this.spa=this.spa.bind(this),this.refine=this.refine.bind(this),this.refinement=this.refinement.bind(this),this.superRefine=this.superRefine.bind(this),this.optional=this.optional.bind(this),this.nullable=this.nullable.bind(this),this.nullish=this.nullish.bind(this),this.array=this.array.bind(this),this.promise=this.promise.bind(this),this.or=this.or.bind(this),this.and=this.and.bind(this),this.transform=this.transform.bind(this),this.default=this.default.bind(this),this.describe=this.describe.bind(this),this.isNullable=this.isNullable.bind(this),this.isOptional=this.isOptional.bind(this)}get description(){return this._def.description}_getType(t){return Un(t.data)}_getOrReturnCtx(t,n){return n||{common:t.parent.common,data:t.data,parsedType:Un(t.data),schemaErrorMap:this._def.errorMap,path:t.path,parent:t.parent}}_processInputParams(t){return{status:new ft,ctx:{common:t.parent.common,data:t.data,parsedType:Un(t.data),schemaErrorMap:this._def.errorMap,path:t.path,parent:t.parent}}}_parseSync(t){const n=this._parse(t);if(qd(n))throw new Error("Synchronous parse encountered promise.");return n}_parseAsync(t){const n=this._parse(t);return Promise.resolve(n)}parse(t,n){const r=this.safeParse(t,n);if(r.success)return r.data;throw r.error}safeParse(t,n){var r;const o={common:{issues:[],async:(r=n==null?void 0:n.async)!==null&&r!==void 0?r:!1,contextualErrorMap:n==null?void 0:n.errorMap},path:(n==null?void 0:n.path)||[],schemaErrorMap:this._def.errorMap,parent:null,data:t,parsedType:Un(t)},i=this._parseSync({data:t,path:o.path,parent:o});return Jd(o,i)}async parseAsync(t,n){const r=await this.safeParseAsync(t,n);if(r.success)return r.data;throw r.error}async safeParseAsync(t,n){const r={common:{issues:[],contextualErrorMap:n==null?void 0:n.errorMap,async:!0},path:(n==null?void 0:n.path)||[],schemaErrorMap:this._def.errorMap,parent:null,data:t,parsedType:Un(t)},o=this._parse({data:t,path:[],parent:r}),i=await(qd(o)?o:Promise.resolve(o));return Jd(r,i)}refine(t,n){const r=o=>typeof n=="string"||typeof n>"u"?{message:n}:typeof n=="function"?n(o):n;return this._refinement((o,i)=>{const s=t(o),l=()=>i.addIssue({code:B.custom,...r(o)});return typeof Promise<"u"&&s instanceof Promise?s.then(a=>a?!0:(l(),!1)):s?!0:(l(),!1)})}refinement(t,n){return this._refinement((r,o)=>t(r)?!0:(o.addIssue(typeof n=="function"?n(r,o):n),!1))}_refinement(t){return new Ln({schema:this,typeName:ne.ZodEffects,effect:{type:"refinement",refinement:t}})}optional(){return nn.create(this)}nullable(){return Wr.create(this)}nullish(){return this.optional().nullable()}array(){return an.create(this)}promise(){return jo.create(this)}or(t){return hs.create([this,t])}and(t){return ms.create(this,t)}transform(t){return new Ln({schema:this,typeName:ne.ZodEffects,effect:{type:"transform",transform:t}})}default(t){const n=typeof t=="function"?t:()=>t;return new pm({innerType:this,defaultValue:n,typeName:ne.ZodDefault})}brand(){return new Ew({typeName:ne.ZodBranded,type:this,...se(void 0)})}describe(t){const n=this.constructor;return new n({...this._def,description:t})}isOptional(){return this.safeParse(void 0).success}isNullable(){return this.safeParse(null).success}}const kw=/^c[^\s-]{8,}$/i,Sw=/^([a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[a-f0-9]{4}-[a-f0-9]{12}|00000000-0000-0000-0000-000000000000)$/i,_w=/^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;class tr extends ce{constructor(){super(...arguments),this._regex=(t,n,r)=>this.refinement(o=>t.test(o),{validation:n,code:B.invalid_string,...de.errToObj(r)}),this.nonempty=t=>this.min(1,de.errToObj(t)),this.trim=()=>new tr({...this._def,checks:[...this._def.checks,{kind:"trim"}]})}_parse(t){if(this._getType(t)!==H.string){const i=this._getOrReturnCtx(t);return Q(i,{code:B.invalid_type,expected:H.string,received:i.parsedType}),re}const r=new ft;let o;for(const i of this._def.checks)if(i.kind==="min")t.data.length<i.value&&(o=this._getOrReturnCtx(t,o),Q(o,{code:B.too_small,minimum:i.value,type:"string",inclusive:!0,message:i.message}),r.dirty());else if(i.kind==="max")t.data.length>i.value&&(o=this._getOrReturnCtx(t,o),Q(o,{code:B.too_big,maximum:i.value,type:"string",inclusive:!0,message:i.message}),r.dirty());else if(i.kind==="email")_w.test(t.data)||(o=this._getOrReturnCtx(t,o),Q(o,{validation:"email",code:B.invalid_string,message:i.message}),r.dirty());else if(i.kind==="uuid")Sw.test(t.data)||(o=this._getOrReturnCtx(t,o),Q(o,{validation:"uuid",code:B.invalid_string,message:i.message}),r.dirty());else if(i.kind==="cuid")kw.test(t.data)||(o=this._getOrReturnCtx(t,o),Q(o,{validation:"cuid",code:B.invalid_string,message:i.message}),r.dirty());else if(i.kind==="url")try{new URL(t.data)}catch{o=this._getOrReturnCtx(t,o),Q(o,{validation:"url",code:B.invalid_string,message:i.message}),r.dirty()}else i.kind==="regex"?(i.regex.lastIndex=0,i.regex.test(t.data)||(o=this._getOrReturnCtx(t,o),Q(o,{validation:"regex",code:B.invalid_string,message:i.message}),r.dirty())):i.kind==="trim"?t.data=t.data.trim():i.kind==="startsWith"?t.data.startsWith(i.value)||(o=this._getOrReturnCtx(t,o),Q(o,{code:B.invalid_string,validation:{startsWith:i.value},message:i.message}),r.dirty()):i.kind==="endsWith"?t.data.endsWith(i.value)||(o=this._getOrReturnCtx(t,o),Q(o,{code:B.invalid_string,validation:{endsWith:i.value},message:i.message}),r.dirty()):pe.assertNever(i);return{status:r.value,value:t.data}}_addCheck(t){return new tr({...this._def,checks:[...this._def.checks,t]})}email(t){return this._addCheck({kind:"email",...de.errToObj(t)})}url(t){return this._addCheck({kind:"url",...de.errToObj(t)})}uuid(t){return this._addCheck({kind:"uuid",...de.errToObj(t)})}cuid(t){return this._addCheck({kind:"cuid",...de.errToObj(t)})}regex(t,n){return this._addCheck({kind:"regex",regex:t,...de.errToObj(n)})}startsWith(t,n){return this._addCheck({kind:"startsWith",value:t,...de.errToObj(n)})}endsWith(t,n){return this._addCheck({kind:"endsWith",value:t,...de.errToObj(n)})}min(t,n){return this._addCheck({kind:"min",value:t,...de.errToObj(n)})}max(t,n){return this._addCheck({kind:"max",value:t,...de.errToObj(n)})}length(t,n){return this.min(t,n).max(t,n)}get isEmail(){return!!this._def.checks.find(t=>t.kind==="email")}get isURL(){return!!this._def.checks.find(t=>t.kind==="url")}get isUUID(){return!!this._def.checks.find(t=>t.kind==="uuid")}get isCUID(){return!!this._def.checks.find(t=>t.kind==="cuid")}get minLength(){let t=null;for(const n of this._def.checks)n.kind==="min"&&(t===null||n.value>t)&&(t=n.value);return t}get maxLength(){let t=null;for(const n of this._def.checks)n.kind==="max"&&(t===null||n.value<t)&&(t=n.value);return t}}tr.create=e=>new tr({checks:[],typeName:ne.ZodString,...se(e)});function Cw(e,t){const n=(e.toString().split(".")[1]||"").length,r=(t.toString().split(".")[1]||"").length,o=n>r?n:r,i=parseInt(e.toFixed(o).replace(".","")),s=parseInt(t.toFixed(o).replace(".",""));return i%s/Math.pow(10,o)}class Ur extends ce{constructor(){super(...arguments),this.min=this.gte,this.max=this.lte,this.step=this.multipleOf}_parse(t){if(this._getType(t)!==H.number){const i=this._getOrReturnCtx(t);return Q(i,{code:B.invalid_type,expected:H.number,received:i.parsedType}),re}let r;const o=new ft;for(const i of this._def.checks)i.kind==="int"?pe.isInteger(t.data)||(r=this._getOrReturnCtx(t,r),Q(r,{code:B.invalid_type,expected:"integer",received:"float",message:i.message}),o.dirty()):i.kind==="min"?(i.inclusive?t.data<i.value:t.data<=i.value)&&(r=this._getOrReturnCtx(t,r),Q(r,{code:B.too_small,minimum:i.value,type:"number",inclusive:i.inclusive,message:i.message}),o.dirty()):i.kind==="max"?(i.inclusive?t.data>i.value:t.data>=i.value)&&(r=this._getOrReturnCtx(t,r),Q(r,{code:B.too_big,maximum:i.value,type:"number",inclusive:i.inclusive,message:i.message}),o.dirty()):i.kind==="multipleOf"?Cw(t.data,i.value)!==0&&(r=this._getOrReturnCtx(t,r),Q(r,{code:B.not_multiple_of,multipleOf:i.value,message:i.message}),o.dirty()):pe.assertNever(i);return{status:o.value,value:t.data}}gte(t,n){return this.setLimit("min",t,!0,de.toString(n))}gt(t,n){return this.setLimit("min",t,!1,de.toString(n))}lte(t,n){return this.setLimit("max",t,!0,de.toString(n))}lt(t,n){return this.setLimit("max",t,!1,de.toString(n))}setLimit(t,n,r,o){return new Ur({...this._def,checks:[...this._def.checks,{kind:t,value:n,inclusive:r,message:de.toString(o)}]})}_addCheck(t){return new Ur({...this._def,checks:[...this._def.checks,t]})}int(t){return this._addCheck({kind:"int",message:de.toString(t)})}positive(t){return this._addCheck({kind:"min",value:0,inclusive:!1,message:de.toString(t)})}negative(t){return this._addCheck({kind:"max",value:0,inclusive:!1,message:de.toString(t)})}nonpositive(t){return this._addCheck({kind:"max",value:0,inclusive:!0,message:de.toString(t)})}nonnegative(t){return this._addCheck({kind:"min",value:0,inclusive:!0,message:de.toString(t)})}multipleOf(t,n){return this._addCheck({kind:"multipleOf",value:t,message:de.toString(n)})}get minValue(){let t=null;for(const n of this._def.checks)n.kind==="min"&&(t===null||n.value>t)&&(t=n.value);return t}get maxValue(){let t=null;for(const n of this._def.checks)n.kind==="max"&&(t===null||n.value<t)&&(t=n.value);return t}get isInt(){return!!this._def.checks.find(t=>t.kind==="int")}}Ur.create=e=>new Ur({checks:[],typeName:ne.ZodNumber,...se(e)});class Ba extends ce{_parse(t){if(this._getType(t)!==H.bigint){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.bigint,received:r.parsedType}),re}return pt(t.data)}}Ba.create=e=>new Ba({typeName:ne.ZodBigInt,...se(e)});class Wa extends ce{_parse(t){if(this._getType(t)!==H.boolean){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.boolean,received:r.parsedType}),re}return pt(t.data)}}Wa.create=e=>new Wa({typeName:ne.ZodBoolean,...se(e)});class Do extends ce{_parse(t){if(this._getType(t)!==H.date){const i=this._getOrReturnCtx(t);return Q(i,{code:B.invalid_type,expected:H.date,received:i.parsedType}),re}if(isNaN(t.data.getTime())){const i=this._getOrReturnCtx(t);return Q(i,{code:B.invalid_date}),re}const r=new ft;let o;for(const i of this._def.checks)i.kind==="min"?t.data.getTime()<i.value&&(o=this._getOrReturnCtx(t,o),Q(o,{code:B.too_small,message:i.message,inclusive:!0,minimum:i.value,type:"date"}),r.dirty()):i.kind==="max"?t.data.getTime()>i.value&&(o=this._getOrReturnCtx(t,o),Q(o,{code:B.too_big,message:i.message,inclusive:!0,maximum:i.value,type:"date"}),r.dirty()):pe.assertNever(i);return{status:r.value,value:new Date(t.data.getTime())}}_addCheck(t){return new Do({...this._def,checks:[...this._def.checks,t]})}min(t,n){return this._addCheck({kind:"min",value:t.getTime(),message:de.toString(n)})}max(t,n){return this._addCheck({kind:"max",value:t.getTime(),message:de.toString(n)})}get minDate(){let t=null;for(const n of this._def.checks)n.kind==="min"&&(t===null||n.value>t)&&(t=n.value);return t!=null?new Date(t):null}get maxDate(){let t=null;for(const n of this._def.checks)n.kind==="max"&&(t===null||n.value<t)&&(t=n.value);return t!=null?new Date(t):null}}Do.create=e=>new Do({checks:[],typeName:ne.ZodDate,...se(e)});class Ha extends ce{_parse(t){if(this._getType(t)!==H.undefined){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.undefined,received:r.parsedType}),re}return pt(t.data)}}Ha.create=e=>new Ha({typeName:ne.ZodUndefined,...se(e)});class Za extends ce{_parse(t){if(this._getType(t)!==H.null){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.null,received:r.parsedType}),re}return pt(t.data)}}Za.create=e=>new Za({typeName:ne.ZodNull,...se(e)});class Qa extends ce{constructor(){super(...arguments),this._any=!0}_parse(t){return pt(t.data)}}Qa.create=e=>new Qa({typeName:ne.ZodAny,...se(e)});class Rr extends ce{constructor(){super(...arguments),this._unknown=!0}_parse(t){return pt(t.data)}}Rr.create=e=>new Rr({typeName:ne.ZodUnknown,...se(e)});class Fn extends ce{_parse(t){const n=this._getOrReturnCtx(t);return Q(n,{code:B.invalid_type,expected:H.never,received:n.parsedType}),re}}Fn.create=e=>new Fn({typeName:ne.ZodNever,...se(e)});class Ya extends ce{_parse(t){if(this._getType(t)!==H.undefined){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.void,received:r.parsedType}),re}return pt(t.data)}}Ya.create=e=>new Ya({typeName:ne.ZodVoid,...se(e)});class an extends ce{_parse(t){const{ctx:n,status:r}=this._processInputParams(t),o=this._def;if(n.parsedType!==H.array)return Q(n,{code:B.invalid_type,expected:H.array,received:n.parsedType}),re;if(o.minLength!==null&&n.data.length<o.minLength.value&&(Q(n,{code:B.too_small,minimum:o.minLength.value,type:"array",inclusive:!0,message:o.minLength.message}),r.dirty()),o.maxLength!==null&&n.data.length>o.maxLength.value&&(Q(n,{code:B.too_big,maximum:o.maxLength.value,type:"array",inclusive:!0,message:o.maxLength.message}),r.dirty()),n.common.async)return Promise.all(n.data.map((s,l)=>o.type._parseAsync(new Qt(n,s,n.path,l)))).then(s=>ft.mergeArray(r,s));const i=n.data.map((s,l)=>o.type._parseSync(new Qt(n,s,n.path,l)));return ft.mergeArray(r,i)}get element(){return this._def.type}min(t,n){return new an({...this._def,minLength:{value:t,message:de.toString(n)}})}max(t,n){return new an({...this._def,maxLength:{value:t,message:de.toString(n)}})}length(t,n){return this.min(t,n).max(t,n)}nonempty(t){return this.min(1,t)}}an.create=(e,t)=>new an({type:e,minLength:null,maxLength:null,typeName:ne.ZodArray,...se(t)});var Ga;(function(e){e.mergeShapes=(t,n)=>({...t,...n})})(Ga||(Ga={}));const ef=e=>t=>new be({...e,shape:()=>({...e.shape(),...t})});function lr(e){if(e instanceof be){const t={};for(const n in e.shape){const r=e.shape[n];t[n]=nn.create(lr(r))}return new be({...e._def,shape:()=>t})}else return e instanceof an?an.create(lr(e.element)):e instanceof nn?nn.create(lr(e.unwrap())):e instanceof Wr?Wr.create(lr(e.unwrap())):e instanceof un?un.create(e.items.map(t=>lr(t))):e}class be extends ce{constructor(){super(...arguments),this._cached=null,this.nonstrict=this.passthrough,this.augment=ef(this._def),this.extend=ef(this._def)}_getCached(){if(this._cached!==null)return this._cached;const t=this._def.shape(),n=pe.objectKeys(t);return this._cached={shape:t,keys:n}}_parse(t){if(this._getType(t)!==H.object){const u=this._getOrReturnCtx(t);return Q(u,{code:B.invalid_type,expected:H.object,received:u.parsedType}),re}const{status:r,ctx:o}=this._processInputParams(t),{shape:i,keys:s}=this._getCached(),l=[];if(!(this._def.catchall instanceof Fn&&this._def.unknownKeys==="strip"))for(const u in o.data)s.includes(u)||l.push(u);const a=[];for(const u of s){const c=i[u],d=o.data[u];a.push({key:{status:"valid",value:u},value:c._parse(new Qt(o,d,o.path,u)),alwaysSet:u in o.data})}if(this._def.catchall instanceof Fn){const u=this._def.unknownKeys;if(u==="passthrough")for(const c of l)a.push({key:{status:"valid",value:c},value:{status:"valid",value:o.data[c]}});else if(u==="strict")l.length>0&&(Q(o,{code:B.unrecognized_keys,keys:l}),r.dirty());else if(u!=="strip")throw new Error("Internal ZodObject error: invalid unknownKeys value.")}else{const u=this._def.catchall;for(const c of l){const d=o.data[c];a.push({key:{status:"valid",value:c},value:u._parse(new Qt(o,d,o.path,c)),alwaysSet:c in o.data})}}return o.common.async?Promise.resolve().then(async()=>{const u=[];for(const c of a){const d=await c.key;u.push({key:d,value:await c.value,alwaysSet:c.alwaysSet})}return u}).then(u=>ft.mergeObjectSync(r,u)):ft.mergeObjectSync(r,a)}get shape(){return this._def.shape()}strict(t){return de.errToObj,new be({...this._def,unknownKeys:"strict",...t!==void 0?{errorMap:(n,r)=>{var o,i,s,l;const a=(s=(i=(o=this._def).errorMap)===null||i===void 0?void 0:i.call(o,n,r).message)!==null&&s!==void 0?s:r.defaultError;return n.code==="unrecognized_keys"?{message:(l=de.errToObj(t).message)!==null&&l!==void 0?l:a}:{message:a}}}:{}})}strip(){return new be({...this._def,unknownKeys:"strip"})}passthrough(){return new be({...this._def,unknownKeys:"passthrough"})}setKey(t,n){return this.augment({[t]:n})}merge(t){return new be({unknownKeys:t._def.unknownKeys,catchall:t._def.catchall,shape:()=>Ga.mergeShapes(this._def.shape(),t._def.shape()),typeName:ne.ZodObject})}catchall(t){return new be({...this._def,catchall:t})}pick(t){const n={};return pe.objectKeys(t).map(r=>{this.shape[r]&&(n[r]=this.shape[r])}),new be({...this._def,shape:()=>n})}omit(t){const n={};return pe.objectKeys(this.shape).map(r=>{pe.objectKeys(t).indexOf(r)===-1&&(n[r]=this.shape[r])}),new be({...this._def,shape:()=>n})}deepPartial(){return lr(this)}partial(t){const n={};if(t)return pe.objectKeys(this.shape).map(r=>{pe.objectKeys(t).indexOf(r)===-1?n[r]=this.shape[r]:n[r]=this.shape[r].optional()}),new be({...this._def,shape:()=>n});for(const r in this.shape){const o=this.shape[r];n[r]=o.optional()}return new be({...this._def,shape:()=>n})}required(){const t={};for(const n in this.shape){let o=this.shape[n];for(;o instanceof nn;)o=o._def.innerType;t[n]=o}return new be({...this._def,shape:()=>t})}keyof(){return fm(pe.objectKeys(this.shape))}}be.create=(e,t)=>new be({shape:()=>e,unknownKeys:"strip",catchall:Fn.create(),typeName:ne.ZodObject,...se(t)});be.strictCreate=(e,t)=>new be({shape:()=>e,unknownKeys:"strict",catchall:Fn.create(),typeName:ne.ZodObject,...se(t)});be.lazycreate=(e,t)=>new be({shape:e,unknownKeys:"strip",catchall:Fn.create(),typeName:ne.ZodObject,...se(t)});class hs extends ce{_parse(t){const{ctx:n}=this._processInputParams(t),r=this._def.options;function o(i){for(const l of i)if(l.result.status==="valid")return l.result;for(const l of i)if(l.result.status==="dirty")return n.common.issues.push(...l.ctx.common.issues),l.result;const s=i.map(l=>new Pn(l.ctx.common.issues));return Q(n,{code:B.invalid_union,unionErrors:s}),re}if(n.common.async)return Promise.all(r.map(async i=>{const s={...n,common:{...n.common,issues:[]},parent:null};return{result:await i._parseAsync({data:n.data,path:n.path,parent:s}),ctx:s}})).then(o);{let i;const s=[];for(const a of r){const u={...n,common:{...n.common,issues:[]},parent:null},c=a._parseSync({data:n.data,path:n.path,parent:u});if(c.status==="valid")return c;c.status==="dirty"&&!i&&(i={result:c,ctx:u}),u.common.issues.length&&s.push(u.common.issues)}if(i)return n.common.issues.push(...i.ctx.common.issues),i.result;const l=s.map(a=>new Pn(a));return Q(n,{code:B.invalid_union,unionErrors:l}),re}}get options(){return this._def.options}}hs.create=(e,t)=>new hs({options:e,typeName:ne.ZodUnion,...se(t)});class vc extends ce{_parse(t){const{ctx:n}=this._processInputParams(t);if(n.parsedType!==H.object)return Q(n,{code:B.invalid_type,expected:H.object,received:n.parsedType}),re;const r=this.discriminator,o=n.data[r],i=this.options.get(o);return i?n.common.async?i._parseAsync({data:n.data,path:n.path,parent:n}):i._parseSync({data:n.data,path:n.path,parent:n}):(Q(n,{code:B.invalid_union_discriminator,options:this.validDiscriminatorValues,path:[r]}),re)}get discriminator(){return this._def.discriminator}get validDiscriminatorValues(){return Array.from(this.options.keys())}get options(){return this._def.options}static create(t,n,r){const o=new Map;try{n.forEach(i=>{const s=i.shape[t].value;o.set(s,i)})}catch{throw new Error("The discriminator value could not be extracted from all the provided schemas")}if(o.size!==n.length)throw new Error("Some of the discriminator values are not unique");return new vc({typeName:ne.ZodDiscriminatedUnion,discriminator:t,options:o,...se(r)})}}function Ka(e,t){const n=Un(e),r=Un(t);if(e===t)return{valid:!0,data:e};if(n===H.object&&r===H.object){const o=pe.objectKeys(t),i=pe.objectKeys(e).filter(l=>o.indexOf(l)!==-1),s={...e,...t};for(const l of i){const a=Ka(e[l],t[l]);if(!a.valid)return{valid:!1};s[l]=a.data}return{valid:!0,data:s}}else if(n===H.array&&r===H.array){if(e.length!==t.length)return{valid:!1};const o=[];for(let i=0;i<e.length;i++){const s=e[i],l=t[i],a=Ka(s,l);if(!a.valid)return{valid:!1};o.push(a.data)}return{valid:!0,data:o}}else return n===H.date&&r===H.date&&+e==+t?{valid:!0,data:e}:{valid:!1}}class ms extends ce{_parse(t){const{status:n,ctx:r}=this._processInputParams(t),o=(i,s)=>{if(Kd(i)||Kd(s))return re;const l=Ka(i.value,s.value);return l.valid?((Xd(i)||Xd(s))&&n.dirty(),{status:n.value,value:l.data}):(Q(r,{code:B.invalid_intersection_types}),re)};return r.common.async?Promise.all([this._def.left._parseAsync({data:r.data,path:r.path,parent:r}),this._def.right._parseAsync({data:r.data,path:r.path,parent:r})]).then(([i,s])=>o(i,s)):o(this._def.left._parseSync({data:r.data,path:r.path,parent:r}),this._def.right._parseSync({data:r.data,path:r.path,parent:r}))}}ms.create=(e,t,n)=>new ms({left:e,right:t,typeName:ne.ZodIntersection,...se(n)});class un extends ce{_parse(t){const{status:n,ctx:r}=this._processInputParams(t);if(r.parsedType!==H.array)return Q(r,{code:B.invalid_type,expected:H.array,received:r.parsedType}),re;if(r.data.length<this._def.items.length)return Q(r,{code:B.too_small,minimum:this._def.items.length,inclusive:!0,type:"array"}),re;!this._def.rest&&r.data.length>this._def.items.length&&(Q(r,{code:B.too_big,maximum:this._def.items.length,inclusive:!0,type:"array"}),n.dirty());const i=r.data.map((s,l)=>{const a=this._def.items[l]||this._def.rest;return a?a._parse(new Qt(r,s,r.path,l)):null}).filter(s=>!!s);return r.common.async?Promise.all(i).then(s=>ft.mergeArray(n,s)):ft.mergeArray(n,i)}get items(){return this._def.items}rest(t){return new un({...this._def,rest:t})}}un.create=(e,t)=>{if(!Array.isArray(e))throw new Error("You must pass an array of schemas to z.tuple([ ... ])");return new un({items:e,typeName:ne.ZodTuple,rest:null,...se(t)})};class gs extends ce{get keySchema(){return this._def.keyType}get valueSchema(){return this._def.valueType}_parse(t){const{status:n,ctx:r}=this._processInputParams(t);if(r.parsedType!==H.object)return Q(r,{code:B.invalid_type,expected:H.object,received:r.parsedType}),re;const o=[],i=this._def.keyType,s=this._def.valueType;for(const l in r.data)o.push({key:i._parse(new Qt(r,l,r.path,l)),value:s._parse(new Qt(r,r.data[l],r.path,l))});return r.common.async?ft.mergeObjectAsync(n,o):ft.mergeObjectSync(n,o)}get element(){return this._def.valueType}static create(t,n,r){return n instanceof ce?new gs({keyType:t,valueType:n,typeName:ne.ZodRecord,...se(r)}):new gs({keyType:tr.create(),valueType:t,typeName:ne.ZodRecord,...se(n)})}}class Xa extends ce{_parse(t){const{status:n,ctx:r}=this._processInputParams(t);if(r.parsedType!==H.map)return Q(r,{code:B.invalid_type,expected:H.map,received:r.parsedType}),re;const o=this._def.keyType,i=this._def.valueType,s=[...r.data.entries()].map(([l,a],u)=>({key:o._parse(new Qt(r,l,r.path,[u,"key"])),value:i._parse(new Qt(r,a,r.path,[u,"value"]))}));if(r.common.async){const l=new Map;return Promise.resolve().then(async()=>{for(const a of s){const u=await a.key,c=await a.value;if(u.status==="aborted"||c.status==="aborted")return re;(u.status==="dirty"||c.status==="dirty")&&n.dirty(),l.set(u.value,c.value)}return{status:n.value,value:l}})}else{const l=new Map;for(const a of s){const u=a.key,c=a.value;if(u.status==="aborted"||c.status==="aborted")return re;(u.status==="dirty"||c.status==="dirty")&&n.dirty(),l.set(u.value,c.value)}return{status:n.value,value:l}}}}Xa.create=(e,t,n)=>new Xa({valueType:t,keyType:e,typeName:ne.ZodMap,...se(n)});class Br extends ce{_parse(t){const{status:n,ctx:r}=this._processInputParams(t);if(r.parsedType!==H.set)return Q(r,{code:B.invalid_type,expected:H.set,received:r.parsedType}),re;const o=this._def;o.minSize!==null&&r.data.size<o.minSize.value&&(Q(r,{code:B.too_small,minimum:o.minSize.value,type:"set",inclusive:!0,message:o.minSize.message}),n.dirty()),o.maxSize!==null&&r.data.size>o.maxSize.value&&(Q(r,{code:B.too_big,maximum:o.maxSize.value,type:"set",inclusive:!0,message:o.maxSize.message}),n.dirty());const i=this._def.valueType;function s(a){const u=new Set;for(const c of a){if(c.status==="aborted")return re;c.status==="dirty"&&n.dirty(),u.add(c.value)}return{status:n.value,value:u}}const l=[...r.data.values()].map((a,u)=>i._parse(new Qt(r,a,r.path,u)));return r.common.async?Promise.all(l).then(a=>s(a)):s(l)}min(t,n){return new Br({...this._def,minSize:{value:t,message:de.toString(n)}})}max(t,n){return new Br({...this._def,maxSize:{value:t,message:de.toString(n)}})}size(t,n){return this.min(t,n).max(t,n)}nonempty(t){return this.min(1,t)}}Br.create=(e,t)=>new Br({valueType:e,minSize:null,maxSize:null,typeName:ne.ZodSet,...se(t)});class xo extends ce{constructor(){super(...arguments),this.validate=this.implement}_parse(t){const{ctx:n}=this._processInputParams(t);if(n.parsedType!==H.function)return Q(n,{code:B.invalid_type,expected:H.function,received:n.parsedType}),re;function r(l,a){return Va({data:l,path:n.path,errorMaps:[n.common.contextualErrorMap,n.schemaErrorMap,ja(),ps].filter(u=>!!u),issueData:{code:B.invalid_arguments,argumentsError:a}})}function o(l,a){return Va({data:l,path:n.path,errorMaps:[n.common.contextualErrorMap,n.schemaErrorMap,ja(),ps].filter(u=>!!u),issueData:{code:B.invalid_return_type,returnTypeError:a}})}const i={errorMap:n.common.contextualErrorMap},s=n.data;return this._def.returns instanceof jo?pt(async(...l)=>{const a=new Pn([]),u=await this._def.args.parseAsync(l,i).catch(p=>{throw a.addIssue(r(l,p)),a}),c=await s(...u);return await this._def.returns._def.type.parseAsync(c,i).catch(p=>{throw a.addIssue(o(c,p)),a})}):pt((...l)=>{const a=this._def.args.safeParse(l,i);if(!a.success)throw new Pn([r(l,a.error)]);const u=s(...a.data),c=this._def.returns.safeParse(u,i);if(!c.success)throw new Pn([o(u,c.error)]);return c.data})}parameters(){return this._def.args}returnType(){return this._def.returns}args(...t){return new xo({...this._def,args:un.create(t).rest(Rr.create())})}returns(t){return new xo({...this._def,returns:t})}implement(t){return this.parse(t)}strictImplement(t){return this.parse(t)}static create(t,n,r){return new xo({args:t||un.create([]).rest(Rr.create()),returns:n||Rr.create(),typeName:ne.ZodFunction,...se(r)})}}class qa extends ce{get schema(){return this._def.getter()}_parse(t){const{ctx:n}=this._processInputParams(t);return this._def.getter()._parse({data:n.data,path:n.path,parent:n})}}qa.create=(e,t)=>new qa({getter:e,typeName:ne.ZodLazy,...se(t)});class Ja extends ce{_parse(t){if(t.data!==this._def.value){const n=this._getOrReturnCtx(t);return Q(n,{code:B.invalid_literal,expected:this._def.value}),re}return{status:"valid",value:t.data}}get value(){return this._def.value}}Ja.create=(e,t)=>new Ja({value:e,typeName:ne.ZodLiteral,...se(t)});function fm(e,t){return new wc({values:e,typeName:ne.ZodEnum,...se(t)})}class wc extends ce{_parse(t){if(typeof t.data!="string"){const n=this._getOrReturnCtx(t),r=this._def.values;return Q(n,{expected:pe.joinValues(r),received:n.parsedType,code:B.invalid_type}),re}if(this._def.values.indexOf(t.data)===-1){const n=this._getOrReturnCtx(t),r=this._def.values;return Q(n,{received:n.data,code:B.invalid_enum_value,options:r}),re}return pt(t.data)}get options(){return this._def.values}get enum(){const t={};for(const n of this._def.values)t[n]=n;return t}get Values(){const t={};for(const n of this._def.values)t[n]=n;return t}get Enum(){const t={};for(const n of this._def.values)t[n]=n;return t}}wc.create=fm;class eu extends ce{_parse(t){const n=pe.getValidEnumValues(this._def.values),r=this._getOrReturnCtx(t);if(r.parsedType!==H.string&&r.parsedType!==H.number){const o=pe.objectValues(n);return Q(r,{expected:pe.joinValues(o),received:r.parsedType,code:B.invalid_type}),re}if(n.indexOf(t.data)===-1){const o=pe.objectValues(n);return Q(r,{received:r.data,code:B.invalid_enum_value,options:o}),re}return pt(t.data)}get enum(){return this._def.values}}eu.create=(e,t)=>new eu({values:e,typeName:ne.ZodNativeEnum,...se(t)});class jo extends ce{_parse(t){const{ctx:n}=this._processInputParams(t);if(n.parsedType!==H.promise&&n.common.async===!1)return Q(n,{code:B.invalid_type,expected:H.promise,received:n.parsedType}),re;const r=n.parsedType===H.promise?n.data:Promise.resolve(n.data);return pt(r.then(o=>this._def.type.parseAsync(o,{path:n.path,errorMap:n.common.contextualErrorMap})))}}jo.create=(e,t)=>new jo({type:e,typeName:ne.ZodPromise,...se(t)});class Ln extends ce{innerType(){return this._def.schema}_parse(t){const{status:n,ctx:r}=this._processInputParams(t),o=this._def.effect||null;if(o.type==="preprocess"){const s=o.transform(r.data);return r.common.async?Promise.resolve(s).then(l=>this._def.schema._parseAsync({data:l,path:r.path,parent:r})):this._def.schema._parseSync({data:s,path:r.path,parent:r})}const i={addIssue:s=>{Q(r,s),s.fatal?n.abort():n.dirty()},get path(){return r.path}};if(i.addIssue=i.addIssue.bind(i),o.type==="refinement"){const s=l=>{const a=o.refinement(l,i);if(r.common.async)return Promise.resolve(a);if(a instanceof Promise)throw new Error("Async refinement encountered during synchronous parse operation. Use .parseAsync instead.");return l};if(r.common.async===!1){const l=this._def.schema._parseSync({data:r.data,path:r.path,parent:r});return l.status==="aborted"?re:(l.status==="dirty"&&n.dirty(),s(l.value),{status:n.value,value:l.value})}else return this._def.schema._parseAsync({data:r.data,path:r.path,parent:r}).then(l=>l.status==="aborted"?re:(l.status==="dirty"&&n.dirty(),s(l.value).then(()=>({status:n.value,value:l.value}))))}if(o.type==="transform")if(r.common.async===!1){const s=this._def.schema._parseSync({data:r.data,path:r.path,parent:r});if(!Ua(s))return s;const l=o.transform(s.value,i);if(l instanceof Promise)throw new Error("Asynchronous transform encountered during synchronous parse operation. Use .parseAsync instead.");return{status:n.value,value:l}}else return this._def.schema._parseAsync({data:r.data,path:r.path,parent:r}).then(s=>Ua(s)?Promise.resolve(o.transform(s.value,i)).then(l=>({status:n.value,value:l})):s);pe.assertNever(o)}}Ln.create=(e,t,n)=>new Ln({schema:e,typeName:ne.ZodEffects,effect:t,...se(n)});Ln.createWithPreprocess=(e,t,n)=>new Ln({schema:t,effect:{type:"preprocess",transform:e},typeName:ne.ZodEffects,...se(n)});class nn extends ce{_parse(t){return this._getType(t)===H.undefined?pt(void 0):this._def.innerType._parse(t)}unwrap(){return this._def.innerType}}nn.create=(e,t)=>new nn({innerType:e,typeName:ne.ZodOptional,...se(t)});class Wr extends ce{_parse(t){return this._getType(t)===H.null?pt(null):this._def.innerType._parse(t)}unwrap(){return this._def.innerType}}Wr.create=(e,t)=>new Wr({innerType:e,typeName:ne.ZodNullable,...se(t)});class pm extends ce{_parse(t){const{ctx:n}=this._processInputParams(t);let r=n.data;return n.parsedType===H.undefined&&(r=this._def.defaultValue()),this._def.innerType._parse({data:r,path:n.path,parent:n})}removeDefault(){return this._def.innerType}}pm.create=(e,t)=>new nn({innerType:e,typeName:ne.ZodOptional,...se(t)});class tu extends ce{_parse(t){if(this._getType(t)!==H.nan){const r=this._getOrReturnCtx(t);return Q(r,{code:B.invalid_type,expected:H.nan,received:r.parsedType}),re}return{status:"valid",value:t.data}}}tu.create=e=>new tu({typeName:ne.ZodNaN,...se(e)});class Ew extends ce{_parse(t){const{ctx:n}=this._processInputParams(t),r=n.data;return this._def.type._parse({data:r,path:n.path,parent:n})}unwrap(){return this._def.type}}be.lazycreate;var ne;(function(e){e.ZodString="ZodString",e.ZodNumber="ZodNumber",e.ZodNaN="ZodNaN",e.ZodBigInt="ZodBigInt",e.ZodBoolean="ZodBoolean",e.ZodDate="ZodDate",e.ZodUndefined="ZodUndefined",e.ZodNull="ZodNull",e.ZodAny="ZodAny",e.ZodUnknown="ZodUnknown",e.ZodNever="ZodNever",e.ZodVoid="ZodVoid",e.ZodArray="ZodArray",e.ZodObject="ZodObject",e.ZodUnion="ZodUnion",e.ZodDiscriminatedUnion="ZodDiscriminatedUnion",e.ZodIntersection="ZodIntersection",e.ZodTuple="ZodTuple",e.ZodRecord="ZodRecord",e.ZodMap="ZodMap",e.ZodSet="ZodSet",e.ZodFunction="ZodFunction",e.ZodLazy="ZodLazy",e.ZodLiteral="ZodLiteral",e.ZodEnum="ZodEnum",e.ZodEffects="ZodEffects",e.ZodNativeEnum="ZodNativeEnum",e.ZodOptional="ZodOptional",e.ZodNullable="ZodNullable",e.ZodDefault="ZodDefault",e.ZodPromise="ZodPromise",e.ZodBranded="ZodBranded"})(ne||(ne={}));const nu=tr.create;Ur.create;tu.create;Ba.create;const Tw=Wa.create;Do.create;Ha.create;Za.create;Qa.create;Rr.create;Fn.create;Ya.create;an.create;const hm=be.create;be.strictCreate;hs.create;vc.create;ms.create;un.create;gs.create;Xa.create;Br.create;xo.create;qa.create;Ja.create;wc.create;eu.create;jo.create;Ln.create;nn.create;Wr.create;Ln.createWithPreprocess;const mm=""+new URL("lock.ffb1587c.svg",import.meta.url).href,bw=""+new URL("word.53c7a4b6.svg",import.meta.url).href;function $w(e,t,{checkForDefaultPrevented:n=!0}={}){return function(o){if(e==null||e(o),n===!1||!o.defaultPrevented)return t==null?void 0:t(o)}}function gm(e){const t=v.exports.useRef(e);return v.exports.useEffect(()=>{t.current=e}),v.exports.useMemo(()=>(...n)=>{var r;return(r=t.current)===null||r===void 0?void 0:r.call(t,...n)},[])}function Pw({prop:e,defaultProp:t,onChange:n=()=>{}}){const[r,o]=Aw({defaultProp:t,onChange:n}),i=e!==void 0,s=i?e:r,l=gm(n),a=v.exports.useCallback(u=>{if(i){const d=typeof u=="function"?u(e):u;d!==e&&l(d)}else o(u)},[i,e,o,l]);return[s,a]}function Aw({defaultProp:e,onChange:t}){const n=v.exports.useState(e),[r]=n,o=v.exports.useRef(r),i=gm(t);return v.exports.useEffect(()=>{o.current!==r&&(i(r),o.current=r)},[r,o,i]),n}function Rw(e){const t=v.exports.useRef({value:e,previous:e});return v.exports.useMemo(()=>(t.current.value!==e&&(t.current.previous=t.current.value,t.current.value=e),t.current.previous),[e])}const Nw=Boolean(globalThis==null?void 0:globalThis.document)?v.exports.useLayoutEffect:()=>{};function Fw(e){const[t,n]=v.exports.useState(void 0);return Nw(()=>{if(e){n({width:e.offsetWidth,height:e.offsetHeight});const r=new ResizeObserver(o=>{if(!Array.isArray(o)||!o.length)return;const i=o[0];let s,l;if("borderBoxSize"in i){const a=i.borderBoxSize,u=Array.isArray(a)?a[0]:a;s=u.inlineSize,l=u.blockSize}else s=e.offsetWidth,l=e.offsetHeight;n({width:s,height:l})});return r.observe(e,{box:"border-box"}),()=>r.unobserve(e)}else n(void 0)},[e]),t}const ym=v.exports.forwardRef((e,t)=>{const{children:n,...r}=e,o=v.exports.Children.toArray(n),i=o.find(Mw);if(i){const s=i.props.children,l=o.map(a=>a===i?v.exports.Children.count(s)>1?v.exports.Children.only(null):v.exports.isValidElement(s)?s.props.children:null:a);return v.exports.createElement(ru,Pt({},r,{ref:t}),v.exports.isValidElement(s)?v.exports.cloneElement(s,void 0,l):null)}return v.exports.createElement(ru,Pt({},r,{ref:t}),n)});ym.displayName="Slot";const ru=v.exports.forwardRef((e,t)=>{const{children:n,...r}=e;return v.exports.isValidElement(n)?v.exports.cloneElement(n,{...Ow(r,n.props),ref:cc(t,n.ref)}):v.exports.Children.count(n)>1?v.exports.Children.only(null):null});ru.displayName="SlotClone";const Lw=({children:e})=>v.exports.createElement(v.exports.Fragment,null,e);function Mw(e){return v.exports.isValidElement(e)&&e.type===Lw}function Ow(e,t){const n={...t};for(const r in t){const o=e[r],i=t[r];/^on[A-Z]/.test(r)?n[r]=(...l)=>{i==null||i(...l),o==null||o(...l)}:r==="style"?n[r]={...o,...i}:r==="className"&&(n[r]=[o,i].filter(Boolean).join(" "))}return{...e,...n}}const zw=["a","button","div","h2","h3","img","li","nav","ol","p","span","svg","ul"],vm=zw.reduce((e,t)=>{const n=v.exports.forwardRef((r,o)=>{const{asChild:i,...s}=r,l=i?ym:t;return v.exports.useEffect(()=>{window[Symbol.for("radix-ui")]=!0},[]),v.exports.createElement(l,Pt({},s,{ref:o}))});return n.displayName=`Primitive.${t}`,{...e,[t]:n}},{}),Iw="Label",[L2,Dw]=Uv(Iw,{id:void 0,controlRef:{current:null}}),jw=e=>{const t=Dw("LabelConsumer"),{controlRef:n}=t;return v.exports.useEffect(()=>{e&&(n.current=e)},[e,n]),t.id},wm="Switch",[Vw,M2]=Dh(wm),[Uw,Bw]=Vw(wm),Ww=v.exports.forwardRef((e,t)=>{const{__scopeSwitch:n,"aria-labelledby":r,name:o,checked:i,defaultChecked:s,required:l,disabled:a,value:u="on",onCheckedChange:c,...d}=e,[p,C]=v.exports.useState(null),S=Hv(t,$=>C($)),E=jw(p),M=r||E,h=v.exports.useRef(!1),f=p?Boolean(p.closest("form")):!0,[g=!1,x]=Pw({prop:i,defaultProp:s,onChange:c});return v.exports.createElement(Uw,{scope:n,checked:g,disabled:a},v.exports.createElement(vm.button,Pt({type:"button",role:"switch","aria-checked":g,"aria-labelledby":M,"aria-required":l,"data-state":xm(g),"data-disabled":a?"":void 0,disabled:a,value:u},d,{ref:S,onClick:$w(e.onClick,$=>{x(z=>!z),f&&(h.current=$.isPropagationStopped(),h.current||$.stopPropagation())})})),f&&v.exports.createElement(Qw,{control:p,bubbles:!h.current,name:o,value:u,checked:g,required:l,disabled:a,style:{transform:"translateX(-100%)"}}))}),Hw="SwitchThumb",Zw=v.exports.forwardRef((e,t)=>{const{__scopeSwitch:n,...r}=e,o=Bw(Hw,n);return v.exports.createElement(vm.span,Pt({"data-state":xm(o.checked),"data-disabled":o.disabled?"":void 0},r,{ref:t}))}),Qw=e=>{const{control:t,checked:n,bubbles:r=!0,...o}=e,i=v.exports.useRef(null),s=Rw(n),l=Fw(t);return v.exports.useEffect(()=>{const a=i.current,u=window.HTMLInputElement.prototype,d=Object.getOwnPropertyDescriptor(u,"checked").set;if(s!==n&&d){const p=new Event("click",{bubbles:r});d.call(a,n),a.dispatchEvent(p)}},[s,n,r]),v.exports.createElement("input",Pt({type:"checkbox","aria-hidden":!0,defaultChecked:n},o,{tabIndex:-1,ref:i,style:{...e.style,...l,position:"absolute",pointerEvents:"none",opacity:0,margin:0}}))};function xm(e){return e?"checked":"unchecked"}const Yw=Ww,Gw=Zw,Kw=T.div`
  display: flex; 
  align-items: center;
  gap: 0.5rem; 
`,Xw=T(Yw)`
  all: unset; 

  width: 1.75rem;
  height: 1rem;

  transition: background 100ms; 
  background: transparent;

  border: 0.0625rem solid #434343;
  border-radius: 0.75rem;

  display: flex; 
  align-items: center; 
  
  &[data-state="checked"] {
    transition: background 100ms; 
    background: #68FF65;
  }
`,qw=T(Gw)`
  display: block; 

  width: 0.875rem;
  height: 0.875rem;

  border-radius: 50%;

  transition: transform 100ms;
  transform: translateX(0.125rem);

  background-color: #FFFFFF;

  &[data-state="checked"] {
    transform: translateX(0.825rem);
  }
`,Jw=T.h2` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  font-size: 0.625rem;
  line-height: 95%;

  letter-spacing: 0.03em;

  color: #FFFFFF;
`;function ex({description:e,onChange:t}){return ee(Kw,{children:[_(Xw,{onCheckedChange:r=>t(r),children:_(qw,{})}),_(Jw,{children:e})]})}const tx=T.div` 
  width: 16.625rem;
  height: 2rem;

  background: transparent; 
  border-radius: 0.5rem;

  overflow: hidden;

  padding: 0.375rem 0.5rem;

  display: flex; 
  align-items: center;
  gap: 0.5rem;

  ::before {
    content: '';

    width: 1.25rem; 
    height: 1.25rem; 

    background: url(${({icon:e})=>e});
    background-size: 100% 100%;
    background-repeat: no-repeat; 
    background-position: center center;
  }

  ::after {
    content: '${({titleLabel:e})=>e}';
    position: absolute;

    transform: translate(0.5rem, -1rem);

    padding: 0 0.125rem;

    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 0.5rem;
    line-height: 100%;

    letter-spacing: 0.03em;

   
  }

  ${({isError:e})=>It`
    border: 0.0625rem solid ${e?"#FF4E4E":"#434343"};

    ::after {
      background: #2C2C2C;
      color: ${e?"#FF4E4E":"#434343"};
    }
  `}
`,nx=T.input` 
  width: 100%;
  height: 100%;

  background: transparent; 

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  font-size: 0.875rem;
  line-height: 100%;

  ::-webkit-input-placeholder {
    color: #434343;
  }

  ${({disabled:e})=>It` 
    color: ${e?"#434343":"#FFFFFF"};
  `}
`;function ou({icon:e,inputProps:t,titleLabel:n,errorMessage:r}){return _(tx,{titleLabel:n,icon:e,isError:!!r,children:_(nx,{...t})})}const rx=Yt` 
  from {
    opacity: 0; 
  }
  to {
    opacity: 1; 
  }
`,ox=T.div` 
  width: 100%; 
  height: 100%; 

  display: grid; 
  grid-template-columns: 1fr; 
  grid-template-rows: 1fr; 
  place-items: center; 

  grid-row: 1; 
  grid-column: 1;

  animation-name: ${rx};
  animation-duration: 200ms; 
  animation-fill-mode: forwards; 

  ::before {
    content: ''; 
    
    width: 100%;
    height: 100%; 

    grid-row: 1; 
    grid-column: 1;

    background: rgba(0, 0, 0, .75); 
    filter: blur(0.125rem);
  }
`,ix=T.form` 
  width: 21.875rem;
  height: 15.5625rem;

  background: #2C2C2C;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 0.5rem;

  display: flex; 
  flex-direction: column;
  align-items: center; 
  gap: 1rem;

  padding: 1.5rem 0;

  grid-row: 1; 
  grid-column: 1;

  z-index: 1;
`,sx=T.h1`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 100%;

  letter-spacing: 0.03em;

  color: #FFFFFF;
`,lx=T.div`
  display: flex; 
  align-items: center;
  gap: 1rem;
`,km=T.button` 
  height: 1.5rem;

  border-radius: 0.5rem;

  padding: 0.375rem 1.625rem; 

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 0.75rem;
  line-height: 100%;

  text-align: center; 
  letter-spacing: 0.03em;

  cursor: pointer;
`,ax=T(km)` 
  background: #1C1C1C;
  color: #AEAEAE;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
`,ux=T(km)` 
  background: #FF4E4E;
  color: #FFFFFF;
  box-shadow: 0 0.0625rem 0.0625rem #FF4E4E;
`,cx=hm({name:nu().max(10,"Nome grande demais!").min(3,"Nome pequeno demais!"),password:nu(),canSpectate:Tw()});function dx({onResponse:e,onBack:t,defaultName:n,hasVip:r}){var d,p;const{messages:o}=xt(),{register:i,handleSubmit:s,reset:l,control:a,formState:u}=yc({resolver:dm(cx),defaultValues:{name:n,password:"",canSpectate:!1}});return _(ox,{children:ee(ix,{onSubmit:s(C=>{l(),e(C)}),children:[_(sx,{children:o.titleToCreateTeam}),_(ou,{titleLabel:o.inputNameLabel,icon:bw,errorMessage:(d=u.errors.name)==null?void 0:d.message,inputProps:{disabled:!r,spellCheck:!1,autoCorrect:"off",autoComplete:"off",min:3,max:10,type:"text",placeholder:o.inputNamePlaceHolder,...i("name")}}),_(ou,{titleLabel:o.inputPasswordLabel,icon:mm,errorMessage:(p=u.errors.password)==null?void 0:p.message,inputProps:{spellCheck:!1,autoCorrect:"off",autoComplete:"off",min:4,type:"password",placeholder:o.inputPasswordPlaceHolder,...i("password")}}),_(sw,{name:"canSpectate",control:a,rules:{required:!0},render:({field:C})=>_(ex,{description:o.toggleAccessToSpectateDescription,...C})}),ee(lx,{children:[_(ax,{type:"button",onClick:()=>t(),children:o.toBack}),_(ux,{type:"submit",children:o.toCreate})]})]})})}const fx=Yt` 
  from {
    opacity: 0; 
  }
  to {
    opacity: 1; 
  }
`,px=T.div` 
  width: 100%; 
  height: 100%; 

  display: grid; 
  grid-template-columns: 1fr; 
  grid-template-rows: 1fr; 
  place-items: center; 

  grid-row: 1; 
  grid-column: 1;

  animation-name: ${fx};
  animation-duration: 200ms; 
  animation-fill-mode: forwards; 

  ::before {
    content: ''; 
    
    width: 100%;
    height: 100%; 

    grid-row: 1; 
    grid-column: 1;

    background: rgba(0, 0, 0, .75); 
    filter: blur(0.125rem);
  }
`,hx=T.form` 
  width: 21.875rem;
  height: 10rem;

  background: #2C2C2C;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 0.5rem;

  display: flex; 
  flex-direction: column;
  align-items: center; 
  gap: 1rem;

  padding: 1.5rem 0;

  grid-row: 1; 
  grid-column: 1;

  z-index: 1;
`,mx=T.h1`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 100%;

  letter-spacing: 0.03em;

  color: #FFFFFF;
`,gx=T.div`
  display: flex; 
  align-items: center;
  gap: 1rem;
`,Sm=T.button` 
  height: 1.5rem;

  border-radius: 0.5rem;

  padding: 0.375rem 1.625rem; 

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 0.75rem;
  line-height: 100%;

  text-align: center; 
  letter-spacing: 0.03em;

  cursor: pointer;
`,yx=T(Sm)` 
  background: #1C1C1C;
  color: #AEAEAE;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
`,vx=T(Sm)` 
  background: #FF4E4E;
  color: #FFFFFF;
  box-shadow: 0 0.0625rem 0.0625rem #FF4E4E;
`,wx=hm({password:nu()});function xx({onResponse:e,onBack:t}){const{messages:n}=xt(),{register:r,handleSubmit:o,reset:i}=yc({resolver:dm(wx),defaultValues:{password:""}});return _(px,{children:ee(hx,{onSubmit:o(l=>{e(l),i()}),children:[_(mx,{children:n.titleToJoinInTeam}),_(ou,{titleLabel:n.inputPasswordLabel,icon:mm,inputProps:{spellCheck:!1,autoCorrect:"off",autoComplete:"off",min:4,type:"password",placeholder:n.inputPasswordPlaceHolder,...r("password")}}),ee(gx,{children:[_(yx,{type:"button",onClick:()=>t(),children:n.toBack}),_(vx,{type:"submit",children:n.toJoin})]})]})})}const kx=Yt`
  from {
    opacity: 0; 
  }
  to { 
    opacity: 1; 
  }
`,Sx=T.section` 
  padding: 3.25rem 0 3.25rem 0; 

  width: 49.375rem;

  display: flex; 
  align-items: center; 
  flex-direction: column; 
  gap: 3rem;

  animation-name: ${kx};
  animation-duration: 500ms; 
  animation-fill-mode: forwards;
`,_x=T.button`
  padding: 0.875rem 5.125rem;

  background: #FF4E4E;
  box-shadow: 0 0.25rem 0.25rem rgba(255, 78, 78, 0.25);
  border-radius: 0.5rem;

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 120%;

  text-align: center;
  letter-spacing: 0.03em;

  color: #FFFFFF;

  cursor: pointer;
`;function Cx(){const{messages:e}=xt(),{setModalRequest:t,setHidden:n}=Ys(),[r,o]=v.exports.useState([]),i=v.exports.useRef(),s=()=>{t(null)},l=async d=>{const{status:p}=await Fe("createTeam",{name:d.name,password:d.password,canSpectate:d.canSpectate});p&&n()},a=async d=>{if(i.current){const{status:p}=await Fe("joinTeam",{team:i.current.id,password:d.password});p&&n()}},u=()=>{Fe("tryCreateTeam",{}).then(({hasVip:d,defaultName:p})=>{t(_(dx,{onResponse:l,onBack:s,hasVip:d,defaultName:p}))})},c=async d=>{if(i.current=d,d.hasPassword)t(_(xx,{onResponse:a,onBack:s}));else{const{status:p}=await Fe("joinTeam",{team:i.current.id});p&&n()}};return v.exports.useEffect(()=>{Fe("availableTeamsToJoin",{}).then(({data:d})=>{o(d)})},[]),ee(Sx,{children:[_(Zs,{cards:r.map(d=>_(Hh,{name:d.name,button:{label:e.toJoin,onClick:c.bind(null,d)},members:d.members,verified:d.verified},d.id))}),_(_x,{onClick:u,children:e.requestToCreateTeam})]})}function Ex(){const[e,t]=v.exports.useState(),[n,r]=v.exports.useState([]);v.exports.useEffect(()=>{Fe("painelCategories",{}).then(({data:s})=>{r(s);const l=s.find(a=>a.placeHolder)||s[0];l&&t(l.id)})},[r,t]);const o=s=>{t(s)};let i=_(mh,{});switch(e){case"teams":i=_(Cx,{});break;case"spectate":i=_(q1,{});break;case"monitor":i=_(G1,{});break;case"challenges":i=_(U1,{});break}return ee(J1,{children:[ee(ew,{children:[n.map((s,l)=>_(zv,{active:e===s.id,onClick:()=>o(s.id),children:s.label},l)),_(Ih,{})]}),i]})}const Tx=T.section` 
  display: flex; 
  align-items: center; 
  justify-content: center; 
  flex-direction: column;
  gap: 1.875rem;

  width: 100%; 
  height: 100%; 
`,bx=T.div` 
  display: flex; 
  flex-direction: column; 
  align-items: flex-start; 
  justify-content: center; 
`,$x=T.h1` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 6rem;
  line-height: 85%;

  letter-spacing: 0.03em;

  background: linear-gradient(90deg, #FF4E4E 0%, #990F0F 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  -webkit-text-fill-color: transparent;

  text-shadow: 0 0 0.5rem rgba(187, 58, 58, 0.75);
`,Px=T.h1`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 6rem;
  line-height: 85%;

  letter-spacing: 0.03em;

  color: #FFFFFF;

  text-shadow: 0 0 0.5rem rgba(255, 255, 255, 0.75);
`,Ax=T(Yr)`
  background: rgba(255, 255, 255, 0.4);
  border-radius: 0.5rem;

  width: 20.5rem;
  height: 1.5rem;

  padding: 0.125rem; 

  display: flex; 
  align-items: center;
  justify-content: start; 

  overflow: hidden;
`,Rx=T(Yr)`
  background: #FFFFFF;
  border-radius: 0.5rem;

  width: ${({progress:e})=>`${e}%`};
  height: 100%;

  transition: width 2s cubic-bezier(0.65, 0, 0.35, 1);
`;function Nx(){const{setLoadingFinished:e}=Ys(),[t,n]=v.exports.useState(0);return v.exports.useEffect(()=>{const o=setTimeout(()=>{n(100)},200);return()=>clearTimeout(o)},[]),ee(Tx,{children:[ee(bx,{children:[_($x,{children:"LATE"}),_(Px,{children:"GAME"})]}),_(Ax,{children:_(Rx,{progress:t,onTransitionEnd:()=>{e()}})})]})}const Fx=Yt`
  from {
    opacity: 0;
  } to {
    opacity: 1;
  }
`,Lx=Yt`
  from {
    opacity: 1;
  } to {
    opacity: 0;
  }
`,Mx=T.main`
  width: 59.125rem;
  height: 42rem;

  background: radial-gradient(34.94% 112.23% at 0% 0%, rgba(0, 0, 0, 0.7) 13.78%, rgba(0, 0, 0, 0) 100%), radial-gradient(53.59% 104.97% at 100% 100%, rgba(0, 0, 0, 0.7) 13.78%, rgba(0, 0, 0, 0) 100%), #434343;
  border-radius: 0.75rem;

  position: absolute;
  left: 50%;
  top: 50%; 

  transform: translate(-50%, -50%);

  display: grid; 
  grid-template-columns: 1fr;
  grid-template-rows: 1fr; 
  place-items: center;

  & > *:first-child {
    grid-row: 1; 
    grid-column: 1;
  }

  ${({show:e})=>It`
      animation-name: ${e?Fx:Lx}; 
      animation-duration: .2s;
      animation-fill-mode: forwards;
  `}
`,Ox=""+new URL("send.618c9666.svg",import.meta.url).href,zx=T.section`
  width: 31.5625rem;
  height: 26.5625rem;

  background: #2C2C2C;
  box-shadow: 0 0 0.25rem rgba(0, 0, 0, 0.5);
  border-radius: 0.5rem;

  padding: 1.875rem 1.5rem 1.875rem 2rem;

  display: flex; 
  flex-direction: column;
  align-items: center;
  gap: 1rem;
`,Ix=T.ol` 
  width: 100%;
  height: 19.3125rem;

  display: flex; 
  flex-direction: column;
  gap: 0.5rem;

  overflow: auto;
  
  padding-right: 1rem;

  ::-webkit-scrollbar {
    width: 0.5rem;
  }

  ::-webkit-scrollbar-track {
    width: 0.5rem;
    border-radius: 0.25rem;

    background: #1C1C1C;
  }

  ::-webkit-scrollbar-thumb {
    border-radius: 0.25rem;

    background: #474747;
  }

  ::-webkit-scrollbar-thumb:hover {
    cursor: pointer;
  } 
`,Dx=T.form`
  height: 2.5rem; 

  display: flex; 
  align-items: center; 
  gap: 0.5rem;
`,jx=T.input` 
  width: 23.125rem;
  height: 100%; 

  background: #434343;
  border-radius: 0.5rem;

  padding: 0.75rem 1.5rem;

  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  font-size: 1rem;
  line-height: 120%;

  color: rgba(255, 255, 255, 1);

  user-select: text;

  ::-webkit-input-placeholder {
    color: rgba(255, 255, 255, .6);
  }
`,Vx=T.button` 
  width: 2rem; 
  height: 2rem;

  background: url(${Ox}); 
  background-size: 100% 100%;
  background-repeat: no-repeat;

  cursor: pointer;
`,Ux=T.li` 
  align-self: ${({alignSelf:e})=>e};

  max-width: 16.25rem;

  padding: 0.5rem 0.75rem 0.5rem 0.75rem;

  flex-grow: 0; 
  flex-shrink: 0; 
  flex-basis: auto;

  display: flex; 
  flex-direction: column;
  gap: 0.25rem;

  background: #1C1C1C;
  border-radius: 0.75rem; 
`,_m=T.h3` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  font-size: 0.375rem;
  line-height: 120%;

  max-width: 100%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;

  color: #434343;
`,Bx=T(_m)`
  align-self: flex-start;
`,Wx=T(_m)`
  align-self: flex-end;
`,Hx=T.p` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 400;
  font-size: 0.625rem;
  line-height: 110%;

  max-width: 100%;
  white-space: pre-wrap;
  overflow: hidden;
  text-align: justify;

  color: #FFFFFF;
`;function Zx({authorIsMyself:e,author:t,content:n,date:r}){const{messages:o}=xt();return ee(Ux,{alignSelf:e?"flex-end":"flex-start",children:[ee(Bx,{children:[o.sendBy," ",t]}),_(Hx,{children:n}),_(Wx,{children:r})]})}const Qx=T.li`
  max-width: 80%;
  min-height: 2.5rem;

  padding: 0.875rem 1.75rem;

  background: #5B5B5B;
  border-radius: 0.75rem;  

  align-self: center;

  display: flex;
  align-items: center;
  justify-content: center; 
`,Yx=T.p` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 0.75rem;
  line-height: 100%;

  max-width: 100%; 
  white-space: nowrap;
  text-overflow: hidden; 
  overflow: hidden; 

  color: #FFFFFF;
`;function Gx({author:e,mode:t}){const{messages:n}=xt();return _(Qx,{children:ee(Yx,{children:[e," ",n.votedForTheMode," ",t]})})}function Kx({messages:e}){const{messages:t}=xt(),{register:n,handleSubmit:r,reset:o}=yc(),i=v.exports.useRef(null),s=({content:l})=>{Fe("sendMessage",{content:l}),o()};return v.exports.useEffect(()=>{if(i.current){const l=i.current;l.scrollTo(0,l.scrollHeight)}},[i,e]),ee(zx,{children:[_(Ix,{ref:i,children:e.map((l,a)=>{switch(l.type){case"text":return _(Zx,{...l},a);case"vote":return _(Gx,{...l},a)}})}),ee(Dx,{onSubmit:r(s),children:[_(jx,{autoComplete:"off",autoCorrect:"off",spellCheck:"false",placeholder:t.typeYourMessage,...n("content",{required:!0,max:255,min:1,value:""})}),_(Vx,{})]})]})}const Xx=T.button` 
  width: 18.5rem;

  min-height: 6.25rem;
  max-height: 6.25rem;

  background: #1C1C1C;
  border-radius: 0.5rem;
  overflow: hidden;
  
  margin: 0.25rem 0 0 0.25rem;

  display: grid; 
  grid-template-columns: 1fr; 
  grid-template-rows: 1fr; 

  transition: box-shadow 200ms linear; 

  box-shadow: none;

  :hover {
    transition: box-shadow 200ms linear; 

    box-shadow: 0 0 0.25rem #FF4E4E;
  }

  cursor: pointer; 

  ${({canVote:e})=>!e&&It` 
    ::after {
      content: 'AGUARDE SUA VEZ';
      
      width: 18.5rem;
      height: 6.25rem;
      line-height: 6.25rem;

      grid-row: 1;
      grid-column: 1;
  
      background: rgba(0, 0, 0, .5);

      font-family: 'Roboto';
      font-style: normal;
      font-weight: 700;
      font-size: 1.5rem;

      letter-spacing: 0.03em;

      text-align: center; 
      padding: auto 0;

      color: #FFFFFF;

      z-index: 1;

      transition: opacity 200ms ease-in; 
      opacity: 0; 
    }

    :hover {
      ::after {
        transition: opacity 200ms ease-in; 

        opacity: 1;
      }
    }

    cursor: default; 
  `}
`,qx=T.div`
  width: 100%; 
  height: 100%; 

  grid-row: 1;
  grid-column: 1;

  padding: 0.6875rem 1.5rem;

  display: flex; 
  justify-content: space-between;
  align-items: flex-end; 
`,Jx=T.img` 
  width: 8.6875rem;
  height: 4.875rem;

  filter: drop-shadow(0 0.25rem 0.5rem rgba(0, 0, 0, 0.5));
`,e2=T.h1`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 120%;

  text-align: center;
  letter-spacing: 0.03em;

  color: #FFFFFF;

  text-shadow: 0 0 0.5rem rgba(255, 255, 255, 0.75);
`;function t2({bannerURL:e,name:t,onClick:n}){const{canVote:r}=wy();return _(Xx,{disabled:!r,canVote:r,onClick:n,children:ee(qx,{children:[_(Jx,{src:e,alt:""}),_(e2,{children:t})]})})}const n2=T.section` 
  width: 19.75rem;
  height: 26.5rem;

  overflow: auto;
  -webkit-overflow-scrolling: touch;

  display: flex;
  align-items: flex-start;
  flex-direction: column; 
  gap: 0.5rem;

  ::-webkit-scrollbar {
    width: 0.5rem;
  }

  ::-webkit-scrollbar-track {
    width: 0.5rem;
    border-radius: 0.25rem;

    background: #1C1C1C;
  }

  ::-webkit-scrollbar-thumb {
    border-radius: 0.25rem;

    background: #474747;
  }

  ::-webkit-scrollbar-thumb:hover {
    cursor: pointer;
  } 
`;function r2({options:e,onVote:t}){return _(n2,{children:e.map((n,r)=>v.exports.createElement(t2,{...n,key:r,onClick:()=>t(n)}))})}const o2=T.div` 
  width: 100%;
  height: 100%; 

  padding: 3rem 3.5rem 4rem 3.5rem;

  display: flex; 
  flex-direction: column; 
  align-items: center; 
  gap: 3.125rem;
`,i2=T.header` 
  width: 100%;

  display: flex; 
  justify-content: space-between;
  align-items: center; 
  gap: 2rem;
`,s2=T.h1` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 3rem;
  line-height: 120%;

  text-align: right;
  letter-spacing: 0.03em;

  color: #FFFFFF;

  text-shadow: 0 0 0.5rem rgba(255, 255, 255, 0.75);
`,l2=T.div` 
  display: flex; 
  align-items: center; 
  gap: 0.75rem;
`;function a2({type:e}){const{messages:t}=xt(),[n,r]=v.exports.useState([]),[o,i]=v.exports.useState();v.exports.useEffect(()=>{Fe(e==="map"?"availableGameMaps":"availableGameModes",{}).then(({data:a})=>{i(a)})},[i,r]);const s=({data:a})=>{switch(a.action){case"updateChat":r(u=>[...u,a.message]);break}};v.exports.useEffect(()=>(window.addEventListener("message",s),()=>window.removeEventListener("message",s)));const l=a=>{Fe(e==="map"?"voteGameMap":"voteGameMode",{mode:a.id})};return ee(o2,{children:[ee(i2,{children:[_(Ih,{}),_(s2,{children:t.titleVote})]}),ee(l2,{children:[_(Kx,{messages:n}),o&&_(r2,{onVote:l,options:o})]})]})}function Rl({type:e,closePainel:t}){const[n,r]=v.exports.useState(!0),[o,i]=v.exports.useState(!0),[s,l]=v.exports.useState(0),[a,u]=v.exports.useState(null),c=M=>{u(M)},d=()=>{i(!1)},p=()=>{n||t()},C=()=>{r(!1),Fe("closeUi",{})},S=({code:M})=>{n&&e==="home"&&M.toLocaleLowerCase()==="escape"&&C()};v.exports.useEffect(()=>{s||Fe("limitMembers",{}).then(({limit:M})=>{l(M)})},[]),v.exports.useEffect(()=>(window.addEventListener("keydown",S),()=>window.removeEventListener("keydown",S)));let E=null;switch(e){case"voteMap":E="map";break;case"voteMode":E="mode";break}return _(Mx,{show:n,onAnimationEnd:p,children:ee(Qo.Provider,{value:{limitMembers:s,setLimitMembers:l,loading:o,setLoadingFinished:d,setModalRequest:c,setHidden:C},children:[o?_(Nx,{}):E?_(a2,{type:E}):_(Ex,{}),a]})})}const iu=T.div`
  display: flex; 
  align-items: center;

  gap: 0.5rem;
`,u2=T.div`
  height: 3.5rem;

  padding: 0.375rem 0.5rem;
  
  background: #2C2C2C;
  box-shadow: 0 0.225rem 0.225rem rgba(0, 0, 0, 0.25);
  border-radius: 0.375rem;

  display: flex; 
  align-items: center;
  gap: 0.5rem;

  & > ${iu}:first-child {
    margin-right: 0.5rem;
  }
`,Nl=T(Zh)`
  width: 2.275rem;
  height: 2.275rem;

  opacity: ${({isAlive:e})=>e?"1.0":"0.25"};
`,Cm=T.p`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;

  font-size: 1.75rem;
  line-height: 100%;

  letter-spacing: 0.03em;
`,c2=T(Cm)`
  color: rgba(174, 174, 174, 0.25);
`,d2=T(Cm)`
  color: #D9D9D9;
`;function tf({players:e}){const t=e.filter(r=>r.isAlive).length,n=e.filter(r=>!r.isAlive).length;return _(u2,{children:e.length>10?ee(mh,{children:[ee(iu,{children:[_(Nl,{isAlive:!0}),_(d2,{children:t})]}),ee(iu,{children:[_(Nl,{isAlive:!1}),_(c2,{children:n})]})]}):e.sort(r=>r.isAlive?-1:1).map((r,o)=>_(Nl,{...r},o))})}const f2=T.section` 
  position: absolute; 
  top: 2rem;
  left: 50%;
  transform: translateX(-50%);

  display: flex; 
  align-items: center;
  justify-content: center; 
  gap: 0.5rem;
`,p2=T.div`
  height: 3.5rem;

  padding: 1rem 1.5rem;

  background: #2C2C2C;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 0.5rem;

  display: flex;
  align-items: center; 
  gap: 2rem;
`,nf=T.span` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 2rem;
  line-height: 100%;

  letter-spacing: 0.03em;

  color: #FFFFFF;
`,h2=T.span` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 2rem;
  line-height: 100%;

  letter-spacing: 0.03em;

  color: #FF4E4E;

  text-shadow: 0 0.225rem 0.225rem rgba(0, 0, 0, 0.25);
`;function m2({leftWins:e,rightWins:t}){return ee(p2,{children:[_(nf,{children:e}),_(h2,{children:"\xD7"}),_(nf,{children:t})]})}function g2({teamLeft:e,teamRight:t}){return ee(f2,{children:[_(tf,{players:e.players}),_(m2,{leftWins:e.wins,rightWins:t.wins}),_(tf,{players:t.players})]})}const y2=T.div` 
  width: 12.5rem;
  height: 5.25rem;

  background: #F81502;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 1rem;

  display: flex; 
  align-items: center; 
  justify-content: center; 
`,v2=T.span`
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 4rem;
  line-height: 4.875rem;

  color: #FFFFFF;
`;function w2({rightScore:e,leftScore:t}){return _(y2,{children:ee(v2,{children:[e,"\xD7",t]})})}const x2=T.div` 
  width: 66.75rem;
  height: 36.75rem;

  background: #2C2C2C;
  box-shadow: 0 0.25rem 0.25rem rgba(0, 0, 0, 0.25);
  border-radius: 1rem;

  display: flex; 
  flex-direction: column; 
  align-items: center; 
  gap: 1rem;

  padding: 2rem 2.875rem; 

  position: absolute; 
  top: 50%; 
  left: 50%; 
  transform: translate(-50%, -50%);
`,k2=T.h1` 
  font-family: 'Roboto';
  font-style: normal;
  font-weight: 700;
  font-size: 2.25rem;
  line-height: 2.75rem;

  color: #FFFFFF;
`,S2=T.div`
  display: flex; 
  align-items: center; 
  gap: 1.5rem;

  width: 100%;
  height: 2.5rem;

  border-bottom: 0.0625rem solid #F81502;

  & > * {
    width: 5rem;

    :first-child {
      width: auto;
      margin-right: auto;
    }
  }
`,_2=T.h1` 
  text-overflow: ellipsis;
  text-align: center;

  font-family: 'Roboto Mono';
  font-style: normal;
  font-weight: 700;
  font-size: 1.25rem;
  line-height: 1.5rem;

  color: #FFFFFF;
`;function C2({columns:e}){return _(S2,{children:e.map((t,n)=>_(_2,{children:t},n))})}const E2=T.div`
  display: flex; 
  align-items: center; 
  gap: 1.5rem;

  width: 100%;
  height: 2rem;

  background: #1C1C1C;

  & > * {
    width: 5rem;

    :first-child {
      width: auto;
      margin-left: 1rem;
      margin-right: auto;
    }
  }
`,T2=T.span` 
  text-align: center;

  font-family: 'Roboto Mono';
  font-style: normal;
  font-weight: 500;
  font-size: 1rem;
  line-height: 1.125rem;

  color: #FFFFFF;
`;function b2({values:e}){return _(E2,{children:e.map((t,n)=>_(T2,{children:t},n))})}const $2=T(Yh)`
  display: flex; 
  flex-direction: column; 
  gap: 0.25rem;

  width: 61rem;
  height: 11.25rem;

  overflow: auto;

  & > * {
    flex-shrink: 0;
  }
`;function rf({team:e}){const{messages:t}=xt();return ee($2,{vertical:!0,horizontal:!1,children:[_(C2,{columns:[e.name,t.kills,t.deaths,t.killPerDeaths]}),e.members.map((n,r)=>_(b2,{values:[n.name,n.kills.toString(),n.deaths.toString(),(n.kills/(n.deaths||1)).toFixed(2)]},r))]})}function P2({teamBottom:e,teamTop:t}){const{messages:n}=xt(),r=()=>{Fe("closeStatistic",{})},o=({code:i})=>{(i.toLocaleLowerCase()==="escape"||i.toLocaleLowerCase()==="tab"||i.toLocaleLowerCase()==="home")&&r()};return v.exports.useEffect(()=>(window.addEventListener("keydown",o),()=>window.removeEventListener("keydown",o))),ee(x2,{children:[_(k2,{children:n.titleStatistic}),_(rf,{team:t}),_(rf,{team:e}),_(w2,{rightScore:t.wins,leftScore:e.wins})]})}function A2(){const[e,t]=v.exports.useState(!1),[n,r]=v.exports.useState(null),[o,i]=v.exports.useState(null),[s,l]=v.exports.useState(null),a=()=>{r(null)},u=({data:c})=>{switch(c.action){case"painel":r(_(Rl,{type:"home",closePainel:a}));break;case"voteMap":c.toggle?r(_(Rl,{type:"voteMap",closePainel:a},"voteMap")):a();break;case"voteMode":c.toggle?r(_(Rl,{type:"voteMode",closePainel:a},"voteMode")):a();break;case"statistic":c.toggle?i(_(P2,{...c.statistic})):i(null);break;case"scoreboard":c.toggle?l(_(g2,{...c.teams})):l(null);break;case"updateVoteStatus":t(c.status);break}};return v.exports.useEffect(()=>(window.addEventListener("message",u),()=>{window.removeEventListener("message",u)})),ee(yh.Provider,{value:{setCanVote:t,canVote:e},children:[n,o,s,_(Ov,{})]})}const R2=$v`
  @media screen and (max-width: 800px), screen and (max-height: 600px) {
    :root {
        font-size: 0.5rem;
    }
  }

  @media screen and (min-width: 800px) and (min-height: 600px) {
    :root {
        font-size: 0.625rem;
    }
  }

  @media screen and (min-width: 1000px) and (min-height: 700px) {
    :root {
        font-size: 0.75rem;
    }
  }

  @media screen and (min-width: 1100px) and (min-height: 700px) {
    :root {
        font-size: 0.8rem;
    }
  }

  @media screen and (min-width: 1300px) and (min-height: 700px) {
    :root {
        font-size: 0.9rem;
    }
  }

  @media screen and (min-width: 1400px) and (min-height: 700px) {
    :root {
        font-size: 0.95rem;
    }
  }

  @media screen and (min-width: 1600px) and (min-height: 800px) {
    :root {
        font-size: 1rem;
    }
  }

  @media screen and (min-width: 1750px) and (min-height: 900px) {
    :root {
        font-size: 1.1rem;
    }
  }

  @media screen and (min-width: 1850px) and (min-height: 1000px) {
    :root {
        font-size: 1.2rem;
    }
  }

  * {
    padding: 0; 
    margin: 0; 
    border: none; 
    outline: none; 

    overflow: hidden;

    box-sizing: border-box;
    -webkit-font-smoothing: antialiased;

    user-select: none;
  }

  body, text-area, input, label { 
    font-family: 'Roboto', sans-serif;
    font-style: normal;
  }
`;Fl.createRoot(document.getElementById("root")).render(ee(vy,{children:[_(R2,{}),_(A2,{})]}));
