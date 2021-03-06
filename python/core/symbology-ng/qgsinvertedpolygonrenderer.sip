class QgsInvertedPolygonRenderer : QgsFeatureRenderer
{
%TypeHeaderCode
#include <qgsinvertedpolygonrenderer.h>
%End
  public:

    /** Constructor
     * @param embeddedRenderer optional embeddedRenderer. If null, a default one will be assigned.
     * Ownership will be transferred.
     */
    QgsInvertedPolygonRenderer( QgsFeatureRenderer *embeddedRenderer /Transfer/ = 0 );

    virtual ~QgsInvertedPolygonRenderer();

    /** Used to clone this feature renderer.*/
    virtual QgsInvertedPolygonRenderer *clone() const /Factory/;

    virtual void startRender( QgsRenderContext &context, const QgsFields &fields );

    /** Renders a given feature.
     * This will here collect features. The actual rendering will be postponed to stopRender()
     * @param feature the feature to render
     * @param context the rendering context
     * @param layer the symbol layer to render, if that makes sense
     * @param selected whether this feature has been selected (this will add decorations)
     * @param drawVertexMarker whether this feature has vertex markers (in edit mode usually)
     * @returns true if the rendering was ok
     */
    virtual bool renderFeature( QgsFeature &feature, QgsRenderContext &context, int layer = -1, bool selected = false, bool drawVertexMarker = false );

    /**
     * The actual rendering will take place here.
     * Features collected during renderFeature() are rendered using the embedded feature renderer
     */
    virtual void stopRender( QgsRenderContext &context );

    /** @returns a textual representation of the renderer */
    virtual QString dump() const;

    /** Proxy that will call this method on the embedded renderer. */
    virtual QSet<QString> usedAttributes( const QgsRenderContext &context ) const;
    /** Proxy that will call this method on the embedded renderer. */
    virtual QgsFeatureRenderer::Capabilities capabilities();
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as symbol2
     */
    virtual QgsSymbolList symbols( QgsRenderContext &context );
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as symbolForFeature2
     */
    virtual QgsSymbol *symbolForFeature( QgsFeature &feature, QgsRenderContext &context );
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as originalSymbolForFeature2
     */
    virtual QgsSymbol *originalSymbolForFeature( QgsFeature &feat, QgsRenderContext &context );
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as symbolsForFeature
     */
    virtual QgsSymbolList symbolsForFeature( QgsFeature &feat, QgsRenderContext &context );
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as originalSymbolsForFeature2
     */
    virtual QgsSymbolList originalSymbolsForFeature( QgsFeature &feat, QgsRenderContext &context );
    /** Proxy that will call this method on the embedded renderer. */
    virtual QgsLegendSymbologyList legendSymbologyItems( QSize iconSize );
    /** Proxy that will call this method on the embedded renderer.
     * @note not available in python bindings
     */
    // virtual QgsLegendSymbolList legendSymbolItems( double scaleDenominator = -1, const QString &rule = "" );
    /** Proxy that will call this method on the embedded renderer.
     * @note available in python bindings as willRenderFeature2
     */
    virtual bool willRenderFeature( QgsFeature &feat, QgsRenderContext &context );

    /** Creates a renderer out of an XML, for loading*/
    static QgsFeatureRenderer* create( QDomElement& element, const QgsReadWriteContext &context ) /Factory/;

    /** Creates an XML representation of the renderer. Used for saving purpose
     * @param doc the XML document where to create the XML subtree
     * @returns the created XML subtree
     */
    virtual QDomElement save( QDomDocument& doc, const QgsReadWriteContext &context );

    void setEmbeddedRenderer( QgsFeatureRenderer *subRenderer /Transfer/ );
    const QgsFeatureRenderer *embeddedRenderer() const;

    virtual void setLegendSymbolItem( const QString &key, QgsSymbol *symbol );

    /** @returns true if the geometries are to be preprocessed (merged with an union) before rendering.*/
    bool preprocessingEnabled() const;
    /**
     * @param enabled enables or disables the preprocessing.
     * When enabled, geometries will be merged with an union before being rendered.
     * It allows fixing some rendering artifacts (when rendering overlapping polygons for instance).
     * This will involve some CPU-demanding computations and is thus disabled by default.
     */
    void setPreprocessingEnabled( bool enabled );

    /** Creates a QgsInvertedPolygonRenderer by a conversion from an existing renderer.
     * @note added in 2.5
     * @returns a new renderer if the conversion was possible, otherwise 0.
     */
    static QgsInvertedPolygonRenderer *convertFromRenderer( const QgsFeatureRenderer *renderer ) /Factory/;
};
