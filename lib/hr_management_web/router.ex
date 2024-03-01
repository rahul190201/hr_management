defmodule HrManagementWeb.Router do
  use HrManagementWeb, :router

  import HrManagementWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {HrManagementWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Other scopes may use custom stacks.
  # scope "/api", HrManagementWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hr_management, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HrManagementWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  scope "/", HrManagementWeb do
    pipe_through :browser
    live "/", HomeLive
  end

  ## Authentication routes

  scope "/", HrManagementWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live "/dashboard", DashboardLive.Index, :index

    live "/attendance_records", AttendanceRecordLive.Index, :index
    live "/attendance_records/new", AttendanceRecordLive.Index, :new
    live "/attendance_records/:id/edit", AttendanceRecordLive.Index, :edit

    live "/attendance_records/:id", AttendanceRecordLive.Show, :show
    live "/attendance_records/:id/show/edit", AttendanceRecordLive.Show, :edit

    live "/leave_requests", LeaveRequestLive.Index, :index
    live "/leave_requests/new", LeaveRequestLive.Index, :new
    live "/leave_requests/:id/edit", LeaveRequestLive.Index, :edit

    live "/leave_requests/:id", LeaveRequestLive.Show, :show
    live "/leave_requests/:id/show/edit", LeaveRequestLive.Show, :edit

    live "/salary_payouts", SalaryPayoutLive.Index, :index
    live "/salary_payouts/new", SalaryPayoutLive.Index, :new
    live "/salary_payouts/:id/edit", SalaryPayoutLive.Index, :edit

    live "/salary_payouts/:id", SalaryPayoutLive.Show, :show
    live "/salary_payouts/:id/show/edit", SalaryPayoutLive.Show, :edit

    live "/performance_reviews", PerformanceReviewLive.Index, :index
    live "/performance_reviews/new", PerformanceReviewLive.Index, :new
    live "/performance_reviews/:id/edit", PerformanceReviewLive.Index, :edit

    live "/performance_reviews/:id", PerformanceReviewLive.Show, :show
    live "/performance_reviews/:id/show/edit", PerformanceReviewLive.Show, :edit

    live "/expense_claims", ExpenseClaimLive.Index, :index
    live "/expense_claims/new", ExpenseClaimLive.Index, :new
    live "/expense_claims/:id/edit", ExpenseClaimLive.Index, :edit

    live "/expense_claims/:id", ExpenseClaimLive.Show, :show
    live "/expense_claims/:id/show/edit", ExpenseClaimLive.Show, :edit

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{HrManagementWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", HrManagementWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{HrManagementWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", HrManagementWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{HrManagementWeb.UserAuth, :mount_current_user}] do
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
    end
  end
end
