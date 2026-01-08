//
// Property.swift
// RaptorHTML
// https://raptor.build
// See LICENSE for license information.
//

import Foundation

// swiftlint:disable type_body_length
// swiftlint:disable file_length
/// A simple property-value pair of strings that is able to store inline styles
public enum Property: Hashable, Equatable, Sendable, Comparable, CustomStringConvertible {
    /// Defines a custom CSS property.
    /// - Parameters:
    ///   - property: The CSS property name.
    ///   - value: The CSS property value.
    case custom(_ property: String, value: String)

    /// Defines a CSS variable (custom property).
    /// - Parameters:
    ///   - name: The variable name (without leading `--`).
    ///   - value: The variable value.
    case variable(_ name: String, value: String)

    /// Specifies the name of the keyframes to use for an animation.
    case animationName(String)

    /// Specifies the duration of an animation cycle.
    case animationDuration(Time)

    /// Specifies when the animation will start.
    case animationDelay(Time)

    /// Specifies how many times an animation should repeat.
    case animationIterationCount(Double)

    /// Specifies whether the animation should play in reverse on alternate cycles.
    case animationDirection(AnimationDirection)

    /// Defines what values are applied before/after the animation executes.
    case animationFillMode(FillMode)

    /// Defines how the animation progresses over time.
    case animationTimingFunction(TimingFunction)

    /// Specifies whether the animation is running or paused.
    case animationPlayState(AnimationPlayState)

    /// Specifies whether the animation can be replaced by another with the same name.
    case animationComposition(AnimationComposition)

    /// Defines a complete transition using shorthand notation.
    case transition(Transition)

    /// Specifies the CSS property to which the transition should apply.
    case transitionProperty(TransitionProperty)

    /// Specifies how long a transition should take to complete.
    case transitionDuration(Time)

    /// Specifies how long to wait before starting a transition.
    case transitionDelay(Time)

    /// Defines the speed curve of a transition effect.
    case transitionTimingFunction(TimingFunction)

    /// Controls whether the element participates in shared element transitions.
    case viewTransitionName(String?)

    /// Defines motion path animation behavior.
    case offsetPath(MotionPath)

    /// Sets the position along a motion path.
    case offsetDistance(LengthUnit?)

    /// Defines the rotation applied to the element along its motion path.
    case offsetRotate(OffsetRotate)

    /// Defines the anchor point used to position the element on its motion path.
    case offsetAnchor(OffsetAnchor)

    /// Sets the background color of an element.
    case backgroundColor(Color)

    /// Sets the background image (URL or gradient).
    case backgroundImage(String)

    /// Specifies whether a background image scrolls with the element or is fixed.
    case backgroundAttachment(BackgroundAttachment)

    /// Defines how background images blend with the background color.
    case backgroundBlendMode(BackgroundBlendMode)

    /// Specifies whether an element's background extends under its border.
    case backgroundClip(BackgroundClip)

    /// Specifies the origin position of a background image.
    case backgroundOrigin(BackgroundOrigin)

    /// Controls how background images are positioned.
    case backgroundPosition(BackgroundPosition)

    /// Sets the horizontal starting position of a background image.
    case backgroundPositionX(LengthUnit?)

    /// Sets the vertical starting position of a background image.
    case backgroundPositionY(LengthUnit?)

    /// Controls whether background images are repeated.
    case backgroundRepeat(BackgroundRepeat)

    /// Controls the size of background images.
    case backgroundSize(BackgroundSize)

    /// Applies graphical effects like blur or color shift to the area behind an element.
    case backdropFilter(BackdropFilter)

    /// Determines whether the back face of an element is visible when facing the user.
    case backfaceVisibility(BackfaceVisibility)

    /// Applies graphical effects like blur or color shift to an element.
    case filter(Filter)

    /// Sets how an element's content should blend with its background.
    case mixBlendMode(MixBlendMode)

    /// Specifies a mask image.
    case maskImage(MaskImage)

    /// Specifies how the mask image values should be interpreted.
    case maskMode(MaskMode)

    /// Specifies the size of a mask.
    case maskSize(MaskSize)

    /// Sets how a mask image is repeated.
    case maskRepeat(MaskRepeat)

    /// Specifies the origin position of a mask.
    case maskOrigin(MaskOrigin)

    /// Specifies how mask layers are combined.
    case maskComposite(MaskComposite)

    /// Specifies whether the mask is treated as a luminance or alpha mask.
    case maskType(MaskType)

    /// Defines the border width.
    case borderWidth(LengthUnit?)

    /// Defines the border color.
    case borderColor(Color)

    /// Defines the border radius.
    case borderRadius(LengthUnit?)

    /// Defines the border style (e.g., solid, dashed).
    case borderStyle(StrokeStyle)

    /// Defines a full border shorthand (`width style color`).
    case border(Stroke)

    /// Sets all the border properties for the top border.
    case borderTop(Stroke)

    /// Sets all the border properties for the right border.
    case borderRight(Stroke)

    /// Sets all the border properties for the bottom border.
    case borderBottom(Stroke)

    /// Sets all the border properties for the left border.
    case borderLeft(Stroke)

    /// Defines the shape or curvature of an element's corners.
    case cornerShape(CornerShape)

    /// Sets the radius of the top-left corner.
    case borderTopLeftRadius(LengthUnit)

    /// Sets the radius of the top-right corner.
    case borderTopRightRadius(LengthUnit)

    /// Sets the radius of the bottom-right corner.
    case borderBottomRightRadius(LengthUnit)

    /// Sets the radius of the bottom-left corner.
    case borderBottomLeftRadius(LengthUnit)

    /// Defines the outline width.
    case outlineWidth(LengthUnit?)

    /// Defines the outline color.
    case outlineColor(Color)

    /// Defines the outline style.
    case outlineStyle(StrokeStyle)

    /// Specifies the distance between the outline and the border.
    case outlineOffset(LengthUnit?)

    /// A shorthand property for outline-width, outline-style, and outline-color.
    case outline(Stroke)

    /// Clips the element to a path.
    case clipPath(ClipPath)

    /// Specifies the path to the border image.
    case borderImageSource(BorderImageSource)

    /// Specifies how to slice the border image.
    case borderImageSlice(BorderImageSlice)

    /// Specifies how far the border image extends beyond the border box.
    case borderImageOutset(BorderImageOutset)

    /// Specifies whether the border image should be repeated, rounded, or stretched.
    case borderImageRepeat(BorderImageRepeat)

    /// Specifies the width of the border image.
    case borderImageWidth(LengthUnit?)

    /// Applies an inner shadow (usually an inset shadow).
    case innerShadow(Shadow)

    /// Defines a box shadow.
    case boxShadow(Shadow)

    /// Applies a text shadow.
    case textShadow(TextShadow)

    /// Specifies how an element should be displayed (e.g. `.flex`, `.grid`, `.inlineFlex`).
    case display(Display)

    /// Specifies the element's position method (e.g., absolute, relative).
    case position(Position)

    /// Specifies how content overflows the element's box.
    case overflow(Overflow)

    /// Specifies horizontal overflow behavior.
    case overflowX(Overflow)

    /// Specifies vertical overflow behavior.
    case overflowY(Overflow)

    /// Sets the z-index (stacking order).
    case zIndex(Int)

    /// Sets the element's visibility (visible/hidden).
    case visibility(Visibility)

    /// Controls the opacity of the element.
    case opacity(Double)

    /// Defines the box-sizing mode.
    case boxSizing(BoxSizing)

    /// Defines a clipping rectangle (legacy `clip` property).
    case clip(String)

    /// Sets whether to use isolation for blending contexts.
    case isolation(Isolation)

    /// Sets pointer-events handling.
    case pointerEvents(PointerEvents)

    /// Controls the cursor when hovering over the element.
    case cursor(Cursor)

    /// Sets the width of an element.
    case width(LengthUnit?)

    /// Sets the height of an element.
    case height(LengthUnit?)

    /// Sets the minimum width of an element.
    case minWidth(LengthUnit?)

    /// Sets the minimum height of an element.
    case minHeight(LengthUnit?)

    /// Sets the maximum width of an element.
    case maxWidth(LengthUnit?)

    /// Sets the maximum height of an element.
    case maxHeight(LengthUnit?)

    /// Specifies aspect ratio.
    case aspectRatio(AspectRatio)

    /// Sets the top offset of an absolutely or relatively positioned element.
    case top(LengthUnit?)

    /// Sets the right offset of an absolutely or relatively positioned element.
    case right(LengthUnit?)

    /// Sets the bottom offset of an absolutely or relatively positioned element.
    case bottom(LengthUnit?)

    /// Sets the left offset of an absolutely or relatively positioned element.
    case left(LengthUnit?)

    /// Sets the top margin of an element.
    case marginTop(LengthUnit)

    /// Sets the right margin of an element.
    case marginRight(LengthUnit)

    /// Sets the bottom margin of an element.
    case marginBottom(LengthUnit)

    /// Sets the left margin of an element.
    case marginLeft(LengthUnit)

    /// Defines the element's margin.
    case margin(LengthUnit)

    /// Defines the margin in the block direction (top and bottom in most writing modes).
    case marginBlock(LengthUnit)

    /// Defines the margin at the block-start edge (e.g. top in LTR writing modes).
    case marginBlockStart(LengthUnit)

    /// Defines the margin at the block-end edge (e.g. bottom in LTR writing modes).
    case marginBlockEnd(LengthUnit)

    /// Defines the margin in the inline direction (left and right in most writing modes).
    case marginInline(LengthUnit?)

    /// Defines the margin at the inline-start edge (e.g. left in LTR writing modes).
    case marginInlineStart(LengthUnit?)

    /// Defines the margin at the inline-end edge (e.g. right in LTR writing modes).
    case marginInlineEnd(LengthUnit?)

    /// Sets the top padding of an element.
    case paddingTop(LengthUnit)

    /// Sets the right padding of an element.
    case paddingRight(LengthUnit)

    /// Sets the bottom padding of an element.
    case paddingBottom(LengthUnit)

    /// Sets the left padding of an element.
    case paddingLeft(LengthUnit)

    /// Defines the element's padding.
    case padding(LengthUnit)

    /// Defines the padding in the block direction (top and bottom in most writing modes).
    case paddingBlock(LengthUnit)

    /// Defines the padding at the block-start edge (e.g. top in LTR writing modes).
    case paddingBlockStart(LengthUnit)

    /// Defines the padding at the block-end edge (e.g. bottom in LTR writing modes).
    case paddingBlockEnd(LengthUnit)

    /// Defines the padding in the inline direction (left and right in most writing modes).
    case paddingInline(LengthUnit)

    /// Defines the padding at the inline-start edge (e.g. left in LTR writing modes).
    case paddingInlineStart(LengthUnit)

    /// Defines the padding at the inline-end edge (e.g. right in LTR writing modes).
    case paddingInlineEnd(LengthUnit)

    /// Defines the direction of flex items within a flex container.
    case flexDirection(FlexDirection)

    /// Specifies whether flex items are forced into a single line or can wrap onto multiple lines.
    case flexWrap(FlexWrap)

    /// Shorthand for `flex-direction` and `flex-wrap`.
    case flexFlow(FlexFlow)

    /// Defines how the browser distributes space between and around flex items on the main axis.
    case justifyContent(JustifyContent)

    /// Defines how flex items are aligned along the cross-axis of the flex container.
    case alignItems(AlignItems)

    /// Defines how multiple lines within a flex container are spaced along the cross-axis.
    case alignContent(AlignContent)

    /// Shorthand for `align-content` and `justify-content`.
    case placeContent(PlaceContent)

    /// Shorthand for `align-items` and `justify-items`.
    case placeItems(PlaceItems)

    /// Specifies the ability of a flex item to grow if necessary.
    case flexGrow(Double)

    /// Specifies the ability of a flex item to shrink if necessary.
    case flexShrink(Double)

    /// Specifies the initial main-size of a flex item before remaining space is distributed.
    case flexBasis(FlexBasis)

    /// Controls the alignment of an individual flex item on the cross-axis.
    case alignSelf(AlignSelf)

    /// Specifies the display order of a flex item relative to its siblings.
    case order(Int)

    /// Defines the column track sizing of a grid container.
    case gridTemplateColumns(GridTrack)

    /// Defines the row track sizing of a grid container.
    case gridTemplateRows(GridTrack)

    /// Defines named grid areas used for template placement.
    case gridTemplateAreas(GridTemplateAreas)

    /// Controls automatic placement behavior of grid items.
    case gridAutoFlow(GridAutoFlow)

    /// Defines automatically generated row sizes for the implicit grid.
    case gridAutoRows(LengthUnit?)

    /// Defines automatically generated column sizes for the implicit grid.
    case gridAutoColumns(LengthUnit?)

    /// Defines the grid area occupied by a single item.
    case gridArea(GridArea)

    /// Defines the starting and ending column lines for a grid item.
    case gridColumn(GridSpan)

    /// Defines the starting column line for a grid item.
    case gridColumnStart(GridLine)

    /// Defines the ending column line for a grid item.
    case gridColumnEnd(GridLine)

    /// Defines the starting and ending row lines for a grid item.
    case gridRow(GridSpan)

    /// Defines the starting row line for a grid item.
    case gridRowStart(GridLine)

    /// Defines the ending row line for a grid item.
    case gridRowEnd(GridLine)

    /// Aligns grid items along the inline axis within their cells.
    case justifyItems(JustifyItems)

    /// Aligns a single grid item within its grid area along the inline axis.
    case justifySelf(JustifySelf)

    /// Aligns grid items along the block (vertical) axis within their cells.
    case alignItemsGrid(AlignItems)

    /// Aligns a single grid item within its grid area along the block axis.
    case alignSelfGrid(AlignSelf)

    /// Defines the vertical gap (gutter) between grid rows.
    case rowGap(LengthUnit)

    /// Defines the horizontal gap (gutter) between grid columns.
    case columnGap(LengthUnit)

    /// Defines uniform or distinct row/column gaps between grid or flex items.
    case gap(Gap)

    /// Specifies how strictly snap points are enforced when scrolling.
    /// Maps to the CSS `scroll-snap-type` property.
    case scrollSnapType(ScrollSnapType)

    /// Applies a transform function.
    case transform(Transform)

    /// Sets the origin point for transformations.
    case transformOrigin(TransformOrigin)

    /// Controls 3D transform style (flat vs preserve-3d).
    case transformStyle(TransformStyle)

    /// Defines the perspective distance for 3D transforms.
    case perspective(LengthUnit?)

    /// Defines the origin point for perspective.
    case perspectiveOrigin(TransformOrigin)

    /// Defines the object-fit behavior for replaced elements (images, videos).
    case objectFit(ObjectFit)

    /// Defines the object-position for replaced elements.
    case objectPosition(ObjectPosition)

    /// Sets the font family.
    case fontFamily(FontFamily)

    /// Sets the font size.
    case fontSize(LengthUnit?)

    /// Sets the font weight.
    case fontWeight(FontWeight)

    /// Sets the font style (normal/italic/oblique).
    case fontStyle(FontStyle)

    /// Sets the font variant (e.g., small caps, normal, etc.).
    case fontVariant(FontVariant)

    /// Adjusts the font's x-height relative to its capital height to maintain
    /// consistent legibility across fallback fonts.
    /// Passing `nil` resets the adjustment (equivalent to `"none"` in CSS).
    case fontSizeAdjust(Double?)

    /// Sets the text color.
    case color(Color)

    /// Sets the line height.
    case lineHeight(LengthUnit)

    /// Sets the letter spacing.
    case letterSpacing(LengthUnit?)

    /// Sets the word spacing.
    case wordSpacing(LengthUnit?)

    /// Aligns text horizontally.
    case textAlign(TextAlign)

    /// Specifies how the last line of a block is aligned.
    case textAlignLast(TextAlignLast)

    /// Specifies the justification method used when `text-align` is `justify`.
    case textJustify(TextJustify)

    /// Controls text decoration (underline, etc.).
    case textDecoration(TextDecoration)

    /// Specifies the color of the text decoration line (underline, overline, etc.).
    case textDecorationColor(Color)

    /// Specifies the thickness of the text decoration line.
    case textDecorationThickness(LengthUnit)

    /// Specifies the style of the text decoration line (e.g., solid, double, dotted).
    case textDecorationStyle(TextDecorationStyle)

    /// Controls text transform (uppercase, lowercase, etc.).
    case textTransform(TextTransform)

    /// Controls text overflow (ellipsis, clip, etc.).
    case textOverflow(TextOverflow)

    /// Controls white-space behavior.
    case whiteSpace(WhiteSpace)

    /// Sets the direction of text (ltr or rtl).
    case direction(WritingDirection)

    /// Controls word breaking behavior.
    case wordBreak(WordBreak)

    /// Controls tab size.
    case tabSize(Int)

    /// Specifies the indentation of the first line in a text block.
    case textIndent(LengthUnit)

    /// Applies emphasis marks to text.
    case textEmphasis(TextEmphasis)

    /// Specifies the color of emphasis marks.
    case textEmphasisColor(Color)

    /// Specifies the type of emphasis marks.
    case textEmphasisStyle(TextEmphasisStyle)

    /// Specifies the position of emphasis marks.
    case textEmphasisPosition(TextEmphasisPosition)

    /// Defines the orientation of text in a line.
    case textOrientation(TextOrientation)

    /// Defines the list style type.
    case listStyleType(ListStyleType)

    /// Defines the list style position.
    case listStylePosition(ListStylePosition)

    /// Defines the list style image.
    case listStyleImage(String?)

    /// Controls content alignment within an element.
    case alignContentProperty(String)

    /// Whether the user can select text
    case userSelect(UserSelect)

    /// How an element is aligned along the vertical axis
    case verticalAlign(VerticalAlign)

    /// The CSS property name (e.g. `"background-color"`).
    public var name: String {
        switch self {
        case .custom(let property, _): property
        case .variable(let name, _): "--\(name)"
        case .animationName: "animation-name"
        case .animationDuration: "animation-duration"
        case .animationDelay: "animation-delay"
        case .animationIterationCount: "animation-iteration-count"
        case .animationDirection: "animation-direction"
        case .animationFillMode: "animation-fill-mode"
        case .animationTimingFunction: "animation-timing-function"
        case .animationPlayState: "animation-play-state"
        case .animationComposition: "animation-composition"
        case .transition: "transition"
        case .transitionProperty: "transition-property"
        case .transitionDuration: "transition-duration"
        case .transitionDelay: "transition-delay"
        case .transitionTimingFunction: "transition-timing-function"
        case .viewTransitionName: "view-transition-name"
        case .offsetPath: "offset-path"
        case .offsetDistance: "offset-distance"
        case .offsetRotate: "offset-rotate"
        case .offsetAnchor: "offset-anchor"
        case .backgroundColor: "background-color"
        case .backgroundImage: "background-image"
        case .backgroundAttachment: "background-attachment"
        case .backgroundBlendMode: "background-blend-mode"
        case .backgroundClip: "background-clip"
        case .backgroundOrigin: "background-origin"
        case .backgroundPosition: "background-position"
        case .backgroundPositionX: "background-position-x"
        case .backgroundPositionY: "background-position-y"
        case .backgroundRepeat: "background-repeat"
        case .backgroundSize: "background-size"
        case .backdropFilter: "backdrop-filter"
        case .backfaceVisibility: "backface-visibility"
        case .filter: "filter"
        case .mixBlendMode: "mix-blend-mode"
        case .maskImage: "mask-image"
        case .maskMode: "mask-mode"
        case .maskSize: "mask-size"
        case .maskRepeat: "mask-repeat"
        case .maskOrigin: "mask-origin"
        case .maskComposite: "mask-composite"
        case .maskType: "mask-type"
        case .borderWidth: "border-width"
        case .borderColor: "border-color"
        case .borderRadius: "border-radius"
        case .borderStyle: "border-style"
        case .border: "border"
        case .borderTop: "border-top"
        case .borderRight: "border-right"
        case .borderBottom: "border-bottom"
        case .borderLeft: "border-left"
        case .cornerShape: "corner-shape"
        case .borderTopLeftRadius: "border-top-left-radius"
        case .borderTopRightRadius: "border-top-right-radius"
        case .borderBottomRightRadius: "border-bottom-right-radius"
        case .borderBottomLeftRadius: "border-bottom-left-radius"
        case .outlineWidth: "outline-width"
        case .outlineColor: "outline-color"
        case .outlineStyle: "outline-style"
        case .outlineOffset: "outline-offset"
        case .outline: "outline"
        case .clipPath: "clip-path"
        case .borderImageSource: "border-image-source"
        case .borderImageSlice: "border-image-slice"
        case .borderImageOutset: "border-image-outset"
        case .borderImageRepeat: "border-image-repeat"
        case .borderImageWidth: "border-image-width"
        case .innerShadow: "box-shadow"
        case .boxShadow: "box-shadow"
        case .textShadow: "text-shadow"
        case .display: "display"
        case .position: "position"
        case .overflow: "overflow"
        case .overflowX: "overflow-x"
        case .overflowY: "overflow-y"
        case .zIndex: "z-index"
        case .visibility: "visibility"
        case .opacity: "opacity"
        case .boxSizing: "box-sizing"
        case .clip: "clip"
        case .isolation: "isolation"
        case .pointerEvents: "pointer-events"
        case .cursor: "cursor"
        case .width: "width"
        case .height: "height"
        case .minWidth: "min-width"
        case .minHeight: "min-height"
        case .maxWidth: "max-width"
        case .maxHeight: "max-height"
        case .aspectRatio: "aspect-ratio"
        case .top: "top"
        case .right: "right"
        case .bottom: "bottom"
        case .left: "left"
        case .marginTop: "margin-top"
        case .marginRight: "margin-right"
        case .marginBottom: "margin-bottom"
        case .marginLeft: "margin-left"
        case .margin: "margin"
        case .marginBlock: "margin-block"
        case .marginBlockStart: "margin-block-start"
        case .marginBlockEnd: "margin-block-end"
        case .marginInline: "margin-inline"
        case .marginInlineStart: "margin-inline-start"
        case .marginInlineEnd: "margin-inline-end"
        case .paddingTop: "padding-top"
        case .paddingRight: "padding-right"
        case .paddingBottom: "padding-bottom"
        case .paddingLeft: "padding-left"
        case .padding: "padding"
        case .paddingBlock: "padding-block"
        case .paddingBlockStart: "padding-block-start"
        case .paddingBlockEnd: "padding-block-end"
        case .paddingInline: "padding-inline"
        case .paddingInlineStart: "padding-inline-start"
        case .paddingInlineEnd: "padding-inline-end"
        case .flexDirection: "flex-direction"
        case .flexWrap: "flex-wrap"
        case .flexFlow: "flex-flow"
        case .justifyContent: "justify-content"
        case .alignItems, .alignItemsGrid: "align-items"
        case .alignContent: "align-content"
        case .placeContent: "place-content"
        case .placeItems: "place-items"
        case .flexGrow: "flex-grow"
        case .flexShrink: "flex-shrink"
        case .flexBasis: "flex-basis"
        case .alignSelf, .alignSelfGrid: "align-self"
        case .order: "order"
        case .gridTemplateColumns: "grid-template-columns"
        case .gridTemplateRows: "grid-template-rows"
        case .gridTemplateAreas: "grid-template-areas"
        case .gridAutoFlow: "grid-auto-flow"
        case .gridAutoRows: "grid-auto-rows"
        case .gridAutoColumns: "grid-auto-columns"
        case .gridArea: "grid-area"
        case .gridColumn: "grid-column"
        case .gridColumnStart: "grid-column-start"
        case .gridColumnEnd: "grid-column-end"
        case .gridRow: "grid-row"
        case .gridRowStart: "grid-row-start"
        case .gridRowEnd: "grid-row-end"
        case .justifyItems: "justify-items"
        case .justifySelf: "justify-self"
        case .rowGap: "row-gap"
        case .columnGap: "column-gap"
        case .gap: "gap"
        case .scrollSnapType: "scroll-snap-type"
        case .transform: "transform"
        case .transformOrigin: "transform-origin"
        case .transformStyle: "transform-style"
        case .perspective: "perspective"
        case .perspectiveOrigin: "perspective-origin"
        case .objectFit: "object-fit"
        case .objectPosition: "object-position"
        case .fontFamily: "font-family"
        case .fontSize: "font-size"
        case .fontWeight: "font-weight"
        case .fontStyle: "font-style"
        case .fontVariant: "font-variant"
        case .fontSizeAdjust: "font-size-adjust"
        case .color: "color"
        case .lineHeight: "line-height"
        case .letterSpacing: "letter-spacing"
        case .wordSpacing: "word-spacing"
        case .textAlign: "text-align"
        case .textAlignLast: "text-align-last"
        case .textJustify: "text-justify"
        case .textDecoration: "text-decoration"
        case .textDecorationColor: "text-decoration-color"
        case .textDecorationThickness: "text-decoration-thickness"
        case .textDecorationStyle: "text-decoration-style"
        case .textTransform: "text-transform"
        case .textOverflow: "text-overflow"
        case .whiteSpace: "white-space"
        case .direction: "direction"
        case .wordBreak: "word-break"
        case .tabSize: "tab-size"
        case .textIndent: "text-indent"
        case .textEmphasis: "text-emphasis"
        case .textEmphasisColor: "text-emphasis-color"
        case .textEmphasisStyle: "text-emphasis-style"
        case .textEmphasisPosition: "text-emphasis-position"
        case .textOrientation: "text-orientation"
        case .listStyleType: "list-style-type"
        case .listStylePosition: "list-style-position"
        case .listStyleImage: "list-style-image"
        case .alignContentProperty: "align-content"
        case .userSelect: "user-select"
        case .verticalAlign: "vertical-align"
        }
    }

    /// The CSS value for the property.
    public var value: String {
        switch self {
        case .custom(_, let value): value
        case .variable(_, let value): value
        case .animationName(let value): value
        case .animationDuration(let value),
             .animationDelay(let value),
             .transitionDuration(let value),
             .transitionDelay(let value): value.css
        case .animationIterationCount(let value): value == .infinity ? "infinite" : value.formatted()
        case .animationDirection(let value): value.rawValue
        case .animationFillMode(let value): value.rawValue
        case .animationTimingFunction(let value),
             .transitionTimingFunction(let value): value.css
        case .animationPlayState(let value): value.css
        case .animationComposition(let value): value.css
        case .transition(let value): value.css
        case .transitionProperty(let value): value.css
        case .viewTransitionName(let value): value ?? "none"
        case .offsetPath(let value): value.css
        case .offsetDistance(let value): value?.css ?? "auto"
        case .offsetRotate(let value): value.css
        case .offsetAnchor(let value): value.css
        case .backgroundColor(let value): value.css
        case .backgroundImage(let value): value
        case .backgroundAttachment(let value): value.css
        case .backgroundBlendMode(let value): value.css
        case .backgroundClip(let value): value.css
        case .backgroundOrigin(let value): value.css
        case .backgroundPosition(let value): value.css
        case .backgroundPositionX(let value),
             .backgroundPositionY(let value): value?.css ?? "auto"
        case .backgroundRepeat(let value): value.css
        case .backgroundSize(let value): value.css
        case .backdropFilter(let value): value.css
        case .backfaceVisibility(let value): value.css
        case .filter(let value): value.css
        case .mixBlendMode(let value): value.css
        case .maskImage(let value): value.css
        case .maskMode(let value): value.css
        case .maskSize(let value): value.css
        case .maskRepeat(let value): value.css
        case .maskOrigin(let value): value.css
        case .maskComposite(let value): value.css
        case .maskType(let value): value.css
        case .borderWidth(let value): value?.css ?? "0"
        case .borderColor(let value): value.css
        case .borderRadius(let value): value?.css ?? "0"
        case .borderStyle(let value): value.rawValue
        case .border(let stroke),
             .borderTop(let stroke),
             .borderRight(let stroke),
             .borderBottom(let stroke),
             .borderLeft(let stroke):
            stroke.css
        case .cornerShape(let value): value.css
        case .borderTopLeftRadius(let value),
             .borderTopRightRadius(let value),
             .borderBottomRightRadius(let value),
             .borderBottomLeftRadius(let value):
            value.css
        case .outlineWidth(let value): value?.css ?? "0"
        case .outlineColor(let value): value.css
        case .outlineStyle(let value): value.rawValue
        case .outlineOffset(let value): value?.css ?? "0"
        case .outline(let value): value.css
        case .clipPath(let value): value.css
        case .borderImageSource(let value): value.css
        case .borderImageSlice(let value): value.css
        case .borderImageOutset(let value): value.css
        case .borderImageRepeat(let value): value.css
        case .borderImageWidth(let value): value?.css ?? "auto"
        case .innerShadow(let value): value.css
        case .boxShadow(let value): value.css
        case .textShadow(let value): value.css
        case .display(let value): value.css
        case .position(let value): value.description
        case .overflow(let value), .overflowX(let value), .overflowY(let value): value.description
        case .zIndex(let value): String(value)
        case .visibility(let value): value.css
        case .opacity(let value): value.formatted()
        case .boxSizing(let value): value.description
        case .clip(let value): value
        case .isolation(let value): value.css
        case .pointerEvents(let value): value.css
        case .cursor(let value): value.css
        case .width(let value), .height(let value),
             .minWidth(let value), .minHeight(let value),
             .maxWidth(let value), .maxHeight(let value),
             .top(let value), .right(let value), .bottom(let value), .left(let value):
            value?.css ?? "auto"
        case .aspectRatio(let value): value.css
        case .marginTop(let value),
             .marginRight(let value),
             .marginBottom(let value),
             .marginLeft(let value),
             .margin(let value):
            value.css
        case .marginBlock(let value),
             .marginBlockStart(let value),
             .marginBlockEnd(let value):
            value.css
        case .marginInline(let value),
             .marginInlineStart(let value),
             .marginInlineEnd(let value):
            value?.css ?? "auto"
        case .paddingTop(let value),
             .paddingRight(let value),
             .paddingBottom(let value),
             .paddingLeft(let value),
             .padding(let value):
            value.css
        case .paddingBlock(let value),
             .paddingBlockStart(let value),
             .paddingBlockEnd(let value),
             .paddingInline(let value),
             .paddingInlineStart(let value),
             .paddingInlineEnd(let value):
            value.css
        case .flexDirection(let value): value.css
        case .flexWrap(let value): value.css
        case .flexFlow(let value): value.css
        case .justifyContent(let value): value.css
        case .alignItems(let value),
             .alignItemsGrid(let value): value.css
        case .alignContent(let value): value.css
        case .placeContent(let value): value.css
        case .placeItems(let value): value.css
        case .flexGrow(let value): String(value)
        case .flexShrink(let value): String(value)
        case .flexBasis(let value): value.css
        case .alignSelf(let value),
             .alignSelfGrid(let value): value.css
        case .order(let value): String(value)
        case .gridTemplateColumns(let value): value.css
        case .gridTemplateRows(let value): value.css
        case .gridTemplateAreas(let value): value.css
        case .gridAutoFlow(let value): value.css
        case .gridAutoRows(let value): value?.css ?? "auto"
        case .gridAutoColumns(let value): value?.css ?? "auto"
        case .gridArea(let value): value.css
        case .gridColumn(let value): value.css
        case .gridColumnStart(let value): value.css
        case .gridColumnEnd(let value): value.css
        case .gridRow(let value): value.css
        case .gridRowStart(let value): value.css
        case .gridRowEnd(let value): value.css
        case .justifyItems(let value): value.css
        case .justifySelf(let value): value.css
        case .rowGap(let value): value.css
        case .columnGap(let value): value.css
        case .gap(let value): value.css
        case .scrollSnapType(let value): value.css
        case .transform(let value): value.css
        case .transformOrigin(let value): value.css
        case .transformStyle(let value): value.css
        case .perspective(let value): value?.css ?? "none"
        case .perspectiveOrigin(let value): value.css
        case .objectFit(let value): value.css
        case .objectPosition(let value): value.css
        case .fontFamily(let value): value.css
        case .fontSize(let value): value?.css ?? "medium"
        case .fontWeight(let value): value.css
        case .fontStyle(let value): value.css
        case .fontVariant(let value): value.css
        case .fontSizeAdjust(let value): value.map { String($0) } ?? "none"
        case .color(let value): value.css
        case .lineHeight(let value): value.css
        case .letterSpacing(let value), .wordSpacing(let value): value?.css ?? "normal"
        case .textAlign(let value): value.rawValue
        case .textAlignLast(let value): value.css
        case .textJustify(let value): value.css
        case .textDecoration(let value): value.css
        case .textDecorationColor(let value): value.css
        case .textDecorationThickness(let value): value.css
        case .textDecorationStyle(let value): value.css
        case .textTransform(let value): value.rawValue
        case .textOverflow(let value): value.css
        case .whiteSpace(let value): value.css
        case .direction(let value): value.css
        case .wordBreak(let value): value.css
        case .tabSize(let value): String(value)
        case .textIndent(let value): value.css
        case .textEmphasis(let value): value.css
        case .textEmphasisColor(let value): value.css
        case .textEmphasisStyle(let value): value.css
        case .textEmphasisPosition(let value): value.css
        case .textOrientation(let value): value.css
        case .listStyleType(let value): value.css
        case .listStylePosition(let value): value.css
        case .listStyleImage(let value): value != nil ? "url('\(value!)')" : "none"
        case .alignContentProperty(let value): value
        case .userSelect(let value): value.rawValue
        case .verticalAlign(let value): value.css
        }
    }

    /// The rendered `"property: value"` CSS declaration string.
    public var description: String { "\(name): \(value)" }

    public static func < (lhs: Property, rhs: Property) -> Bool {
        lhs.description < rhs.description
    }
}

public extension Property {
    /// Sets a background image from a gradient.
    static func backgroundImage(_ gradient: Gradient) -> Self {
        .backgroundImage(gradient.css)
    }

    /// Sets a background image from a gradient.
    static func backgroundImage(_ url: URL) -> Self {
        .backgroundImage("url('\(url.path())')")
    }

    /// Defines a background gradient.
    static func backgroundGradient(_ gradient: Gradient) -> Self {
        .backgroundImage(gradient.css)
    }

    /// Specifies the animation timing function using a keyword.
    static func animationTimingFunction(_ keyword: CSSKeyword) -> Self {
        .animationTimingFunction(.init(keyword.rawValue))
    }

    /// Specifies background position x/y using numeric values.
    static func backgroundPosition(x: LengthUnit?, y: LengthUnit?) -> Self {
        .backgroundPosition(.offset(x: x, y: y))
    }

    /// Sets the height of a line box using a specific unit.
    /// - Parameter value: A `LengthUnit` value (e.g., `.em(1.5)`, `.px(24)`) or `nil` for `"normal"`.
    /// - Returns: An `InlineStyle` for `line-height`.
    static func lineHeight(_ value: LengthUnit?) -> Self {
        .lineHeight(value ?? .custom("normal"))
    }

    /// Sets the height of a line box using a Double multiplier.
    /// - Parameter value: A numeric multiplier (e.g., `1.5`).
    /// - Returns: An `InlineStyle` for `line-height`.
    static func lineHeight(_ value: Double) -> Self {
        .lineHeight(.custom(String(value.formatted(.nonLocalizedDecimal))))
    }
}

public extension Property {
    static func == (lhs: Property, rhs: Property) -> Bool {
        lhs.name == rhs.name && lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(value)
    }
}

public extension Property {
    /// Sets the width of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.auto`, `.fitContent`, or `.maxContent`.
    /// - Returns: An `InlineStyle` for `width`.
    static func width(_ keyword: SizingKeyword) -> Self {
        .width(.custom(keyword.rawValue))
    }

    /// Sets the width of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `width`.
    static func width(_ keyword: CSSKeyword) -> Self {
        .width(.custom(keyword.rawValue))
    }

    /// Sets the height of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.auto`, `.fitContent`, or `.maxContent`.
    /// - Returns: An `InlineStyle` for `height`.
    static func height(_ keyword: SizingKeyword) -> Self {
        .height(.custom(keyword.rawValue))
    }

    /// Sets the height of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `height`.
    static func height(_ keyword: CSSKeyword) -> Self {
        .height(.custom(keyword.rawValue))
    }

    /// Sets the minimum width of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.fitContent` or `.minContent`.
    /// - Returns: An `InlineStyle` for `min-width`.
    static func minWidth(_ keyword: SizingKeyword) -> Self {
        .minWidth(.custom(keyword.rawValue))
    }

    /// Sets the minimum width of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `min-width`.
    static func minWidth(_ keyword: CSSKeyword) -> Self {
        .minWidth(.custom(keyword.rawValue))
    }

    /// Sets the minimum height of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.auto`, `.fitContent`, or `.minContent`.
    /// - Returns: An `InlineStyle` for `min-height`.
    static func minHeight(_ keyword: SizingKeyword) -> Self {
        .minHeight(.custom(keyword.rawValue))
    }

    /// Sets the minimum height of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `min-height`.
    static func minHeight(_ keyword: CSSKeyword) -> Self {
        .minHeight(.custom(keyword.rawValue))
    }

    /// Sets the maximum width of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.fitContent` or `.maxContent`.
    /// - Returns: An `InlineStyle` for `max-width`.
    static func maxWidth(_ keyword: SizingKeyword) -> Self {
        .maxWidth(.custom(keyword.rawValue))
    }

    /// Sets the maximum width of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `max-width`.
    static func maxWidth(_ keyword: CSSKeyword) -> Self {
        .maxWidth(.custom(keyword.rawValue))
    }

    /// Sets the maximum height of an element using a sizing keyword.
    /// - Parameter keyword: A `SizingKeyword` such as `.fitContent` or `.maxContent`.
    /// - Returns: An `InlineStyle` for `max-height`.
    static func maxHeight(_ keyword: SizingKeyword) -> Self {
        .maxHeight(.custom(keyword.rawValue))
    }

    /// Sets the maximum height of an element using a global CSS keyword.
    /// - Parameter keyword: A `CSSKeyword` such as `.inherit`, `.initial`, `.unset`, or `.revert`.
    /// - Returns: An `InlineStyle` for `max-height`.
    static func maxHeight(_ keyword: CSSKeyword) -> Self {
        .maxHeight(.custom(keyword.rawValue))
    }

    /// Defines the gap (gutter) between grid rows and columns.
    /// - Parameter value: A uniform spacing applied to both row and column tracks.
    /// - Returns: An `InlineStyle` for `gap`.
    static func gap(_ value: LengthUnit) -> Self {
        .gap(.all(value))
    }
}

public extension Property {
    /// Specifies whether an element's background extends under its border using a keyword.
    static func backgroundClip(_ keyword: CSSKeyword) -> Self {
        .custom("background-clip", value: keyword.rawValue)
    }

    /// Specifies the origin position of a background image using a keyword.
    static func backgroundOrigin(_ keyword: CSSKeyword) -> Self {
        .custom("background-origin", value: keyword.rawValue)
    }

    /// Specifies the origin position of a background image using a keyword.
    static func display(_ keyword: CSSKeyword) -> Self {
        .custom("display", value: keyword.rawValue)
    }
}
// swiftlint:enable type_body_length
// swiftlint:enable file_length
