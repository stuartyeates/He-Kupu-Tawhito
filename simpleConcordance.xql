xquery version "1.0";
 
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xml media-type=application/xml process-xsl-pi=yes indent=yes"; 
 
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
              let    $collection := '/db/he_kupu_tawhito/',
                     $q := request:get-parameter('kupu', 'mohio'),
                     $lang := request:get-parameter('reo', 'mi'),
                     $first := request:get-parameter('kotahi', 1) cast as xs:decimal,
                     $last := 15 + $first
              return
         <entry xml:lang="{$lang}" n="{$last}">
            <form>
               <orth>{$q}</orth>
            </form>{
                    for $this at $count in subsequence(//p[@n][.//w[@lemma=$q][@xml:lang=$lang]], $first,  $last)     
		      let $words := $this//w[@lemma=$q][@xml:lang=$lang]/@xml:id
                      let $thisid :=  $this/@xml:id
                      let $url := $this/@n
		      
                      return
                      <cit n="{$url}"  corresp="#{$words}">
                          {$this}
                      </cit>
                    }
         </entry>

      }        
      </div>
    </body>
  </text>
</TEI>
}
