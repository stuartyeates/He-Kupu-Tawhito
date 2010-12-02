xquery version "1.0";
 
declare default element namespace "http://www.tei-c.org/ns/1.0";
(: declare option exist:serialize "method=html media-type=text/xml indent=yes"; :)
declare option exist:serialize "method=xml media-type=application/xml process-xsl-pi=yes indent=yes"; 
 
(: let $collection := '/db/kupu/korero' :)
(: let $q := request:get-parameter('kupu', 'mohio') :)
(: let $lang := request:get-parameter('lang', 'mi') :)


(: let $q := request:get-parameter('q', '')  :)
(: let $q :=  'mohio' :)
(: let $lang := 'mi' :)

let $target := 'xml-stylesheet',
    $content := 'href="teiresults2htmlresults.xsl" type="text/xsl" '

return  processing-instruction {$target} {$content}, 
document {
<TEI>
  <teiHeader>
  </teiHeader>
  <text>
    <body>
      <div> {
              let    $collection := '/db/kupu/korero',
                     $q := request:get-parameter('kupu', 'mohio'),
                     $lang := request:get-parameter('reo', 'mi'),
                     $first := request:get-parameter('kotahi', 1) cast as xs:decimal,
                     $last := 15 + $first
              return
         <entry xml:lang="{$lang}" n="{$last}">
            <form>
               <orth>{$q}</orth>
            </form>{
  for $word at $count in subsequence(collection($collection)//w[@lemma=$q][@xml:lang=$lang], $first,  $last)
     let $this := $word/ancestor::*[@n][1]
     let $thisid := $this/@xml:id
     let $url := $this/@n
     let $lang := $word/@xml:lang
     let $that :=
         if ( $this/@corresp )
         then (
           $this/../../*/*[concat('#',@xml:id)=$this/@corresp]
         ) else (
         "no corresp"
         )
     return
         <cit n="{$url}" corresp="#{$word/@xml:id}">
           {$this}
           
           {$that}
	 </cit>
	  
   }</entry>

      }        
      </div>
    </body>
  </text>
</TEI>
}
