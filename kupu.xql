xquery version "1.0";
 
declare default element namespace "http://www.tei-c.org/ns/1.0";
declare option exist:serialize "method=xml media-type=application/xml process-xsl-pi=yes indent=yes"; 
 
let $target := 'xml-stylesheet',
    $content := 'href="kuputei2html.xsl" type="text/xsl" '

return  processing-instruction {$target} {$content}, 
document {
              let    $collection := '/db/he_kupu_tawhito/',
                     $kupu := request:get-parameter('kupu', 'mohio'),
                     $reo := request:get-parameter('reo', 'mi'),
                     $kotahi := request:get-parameter('kotahi', 1) cast as xs:decimal,
                     $last := 15 + $kotahi
              return
<TEI>
  <teiHeader>
     <fileDesc>
        <titleStmt> Rapunga: {$kupu} </titleStmt>
        <publicationStmt><p><ref target="https://github.com/stuartyeates/He-Kupu-Tawhito">He Kupu Tawhito</ref></p></publicationStmt>
        <sourceDesc>
	   <idno type="url.path">kupu.xql</idno>
	   <idno type="url.query.kupu">{$kupu}</idno>
	   <idno type="url.query.reo">{$reo}</idno>
	   <idno type="url.query.kotahi">{$kotahi}</idno>
        </sourceDesc>
     </fileDesc>
  </teiHeader>
  <text>
    <body>
      <div>
          <entry xml:lang="{$reo}" n="{$last}">
            <form>
               <orth>{$kupu}</orth>
            </form>{
                    for $this at $count in subsequence(//p[@n][.//w[@lemma=$kupu][@xml:lang=$reo]], $kotahi,  $last)     
		      let $words := $this//w[@lemma=$kupu][@xml:lang=$reo]/@xml:id
                      let $thisid :=  $this/@xml:id
		      let $thishash := concat('#', $thisid)
                      let $url := $this/@n
		      let $others := //p[contains($this/@corresp,@xml:id)][(concat('#',@xml:id)=$this/@corresp) or (concat('#',$this/@xml:id)=@corresp)] |
		      	  //p[contains(@corresp,$this/@xml:id)][(concat('#',@xml:id)=$this/@corresp) or (concat('#',$this/@xml:id)=@corresp)]
		      
                      return
                      <cit n="{$url}"  corresp="{$words}">
                          {$this}
                          {$others}
                      </cit>
                    }
         </entry>

      </div>
    </body>
  </text>
</TEI>
}
