import SwiftUI

/// Reusable onboarding splash screen view (customizable for onboarding flows)
struct OnboardingView: View {
    // Animation state
    @State private var animateLogo = false
    @State private var animateText = false

    var body: some View {
        ZStack {
            // Full-screen green gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color("OnboardingGreen1"), Color("OnboardingGreen2")]),
                startPoint: .topLeading, endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack {
                Spacer(minLength: 0)
                
                // Animated medical cross logo
                LogoWithShadow()
                    .scaleEffect(animateLogo ? 1 : 0.7)
                    .opacity(animateLogo ? 1 : 0)
                    .shadow(color: Color.white.opacity(0.18), radius: 22, y: 6)
                    .animation(.easeOut(duration: 0.9), value: animateLogo)
                    .padding(.bottom, 36) // Breathing space

                // App name with elegant, calm font
                Text("Healith")
                    .font(.system(size: 42, weight: .semibold, design: .serif))
                    .foregroundColor(.white)
                    .kerning(1)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 0.7).delay(0.25), value: animateText)
                    .shadow(color: Color.black.opacity(0.08), radius: 3, y: 1)
                
                // Subtitle
                Text("Find your peace")
                    .font(.system(size: 19, weight: .regular, design: .rounded))
                    .foregroundColor(Color.white.opacity(0.93))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                    .opacity(animateText ? 1 : 0)
                    .animation(.easeOut(duration: 0.7).delay(0.47), value: animateText)
                                
                Spacer()
                
                // PageControl-style indicator (3 dots) at bottom
                PageIndicator(current: 0, count: 3)
                    .padding(.bottom, 36)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onAppear {
            // Start fade/scale-in animations
            withAnimation { animateLogo = true }
            withAnimation { animateText = true }
        }
    }
}

/// Logo component with shadow/glow for premium feel
private struct LogoWithShadow: View {
    var body: some View {
        ZStack {
            // Shadow/glow
            MedicalCrossShape()
                .fill(Color.white.opacity(0.2))
                .blur(radius: 6)
                .scaleEffect(1.12)
            // Actual cross icon
            MedicalCrossShape()
                .fill(Color.white)
        }
        .frame(maxWidth: .infinity)
        .aspectRatio(1, contentMode: .fit)
        .frame(height: 110) // Responsive with VStack padding
        // Comment: The above `aspectRatio` and `frame` allow logo to size responsively without hardcoding
    }
}

/// Placeholder for a premium medical cross; customize as needed to match your brand
struct MedicalCrossShape: Shape {
    func path(in rect: CGRect) -> Path {
        let w = rect.width, h = rect.height
        let thickness = min(w, h) * 0.22
        let radius = min(w, h) * 0.19

        var path = Path()
        // Draw a stylized "looped" cross (rounded, modern)
        path.addRoundedRect(in: CGRect(x: w/2 - thickness/2, y: rect.minY + h * 0.13, width: thickness, height: h - h * 0.26), cornerSize: CGSize(width: radius, height: radius))
        path.addRoundedRect(in: CGRect(x: rect.minX + w * 0.13, y: h/2 - thickness/2, width: w - w * 0.26, height: thickness), cornerSize: CGSize(width: radius, height: radius))
        return path
    }
}

// Page indicator (3 dots)
private struct PageIndicator: View {
    var current: Int
    var count: Int

    var body: some View {
        HStack(spacing: 14) {
            ForEach(0..<count, id: \.self) { idx in
                Circle()
                    .fill(idx == current ? Color.white.opacity(0.92) : Color.white.opacity(0.48))
                    .frame(width: idx == current ? 10 : 8, height: idx == current ? 10 : 8)
                    .scaleEffect(idx == current ? 1.06 : 1)
                    .animation(.spring(response: 0.4, dampingFraction: 0.92), value: current)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingView()
                .previewDevice("iPhone 14 Pro")
            OnboardingView()
                .previewDevice("iPhone SE (3rd generation)")
        }
    }
}

// MARK: - Suggestion: Add these Color assets to Assets.xcassets
// "OnboardingGreen1": #009D7C
// "OnboardingGreen2": #027356

